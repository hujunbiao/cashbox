import 'dart:async';
import 'dart:typed_data';

import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:logger/logger.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../res/resources.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';

class TransferEthPage extends StatefulWidget {
  @override
  _TransferEthPageState createState() => _TransferEthPageState();
}

class _TransferEthPageState extends State<TransferEthPage> {
  TextEditingController _toAddressController = TextEditingController();
  TextEditingController _txValueController = TextEditingController();
  TextEditingController _backupMsgController = TextEditingController();
  ChainType chainType;
  bool isShowExactGas = false;
  int precision = 8; //Decimal precision
  int eth2gasUnit = 1000 * 1000 * 1000; // 1 ETH = 1e9 gwei (10 to the ninth power) = 1e18 wei
  String Gwei = "Gwei";
  String arrowDownIcon = "assets/images/ic_expand.png";
  String arrowUpIcon = "assets/images/ic_collapse.png";
  String arrowIcon = "assets/images/ic_collapse.png";
  double mMaxGasPrice;
  double mMinGasPrice;
  double mMaxGasLimit;
  double mMinGasLimit;
  double mGasPriceValue;
  double mGasLimitValue;
  double mMaxGasFee;
  double mMinGasFee;
  double mGasFeeValue = 0;
  String digitBalance = "";
  String ethBalance = "";
  String fromAddress = "";
  String contractAddress = "";
  String digitName = "";
  String nonce = "";
  int decimal = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initDataConfig();
  }

  void initDataConfig() async {
    {
      fromAddress = Provider.of<TransactionProvide>(context).fromAddress;
      contractAddress = Provider.of<TransactionProvide>(context).contractAddress;
      decimal = Provider.of<TransactionProvide>(context).decimal;
      chainType = Provider.of<TransactionProvide>(context).chainType;
      digitBalance = Provider.of<TransactionProvide>(context).balance;
    }
    if (fromAddress == null || fromAddress.trim() == "") {
      fromAddress = Wallets.instance.nowWallet.nowChain.chainAddress;
    }
    if (chainType == null) {
      chainType = Wallets.instance.nowWallet.nowChain.chainType;
    }
    if (decimal == null) {
      decimal = 18;
    }
    _txValueController.text = Provider.of<TransactionProvide>(context).txValue ?? "";
    _toAddressController.text = Provider.of<TransactionProvide>(context).toAddress ?? "";
    _backupMsgController.text = Provider.of<TransactionProvide>(context).backup ?? "";

    Config config = await HandleConfig.instance.getConfig();
    if (contractAddress != null && contractAddress.trim() != "") {
      mMaxGasPrice = config.maxGasLimit.erc20GasLimit;
      mMinGasPrice = config.minGasPrice.erc20GasPrice;
      mMaxGasLimit = config.maxGasLimit.erc20GasLimit;
      mMinGasLimit = config.minGasLimit.erc20GasLimit;
      mGasLimitValue = config.defaultGasLimit.erc20GasLimit;
      mGasPriceValue = config.defaultGasPrice.erc20GasPrice;
    } else {
      mMaxGasPrice = config.maxGasLimit.ethGasLimit;
      mMinGasPrice = config.minGasPrice.ethGasPrice;
      mMaxGasLimit = config.maxGasLimit.ethGasLimit;
      mMinGasLimit = config.minGasLimit.ethGasLimit;
      mGasLimitValue = config.defaultGasLimit.ethGasLimit;
      mGasPriceValue = config.defaultGasPrice.ethGasPrice;
    }
    setState(() {
      this.mMaxGasPrice = mMaxGasPrice;
      this.mMinGasPrice = mMinGasPrice;
      this.mMaxGasLimit = mMaxGasLimit;
      this.mMinGasLimit = mMinGasLimit;
      this.mGasLimitValue = mGasLimitValue;
      this.mGasPriceValue = mGasPriceValue;
      mMaxGasFee = mMaxGasLimit * mMaxGasPrice / eth2gasUnit;
      mMinGasFee = mMinGasLimit * mMinGasPrice / eth2gasUnit;
      mGasFeeValue = mGasLimitValue * mGasPriceValue / eth2gasUnit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: translate('wallet_transfer'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: _buildTransferEthWidget(),
        ),
      ),
    );
  }

  Widget _buildTransferEthWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.scaleVGap(5),
            _buildToAddressWidget(),
            Gaps.scaleVGap(5),
            _buildValueWidget(),
            Gaps.scaleVGap(5),
            _buildGasFeeWidget(),
            Gaps.scaleVGap(3),
            _buildHideDetailWidget(),
            Gaps.scaleVGap(15),
            _buildTransferBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildGasFeeWidget() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(40),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      translate('mine_fee'),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: ScreenUtil().setWidth(40),
                    child: Text(
                      Utils.formatDouble(mGasFeeValue, precision: precision).toString() + (digitName ?? ""),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                    ),
                  )
                ],
              ),
            )),
        Container(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blueAccent,
              activeTickMarkColor: Colors.white,
              inactiveTickMarkColor: Colors.white,
              inactiveTrackColor: Colors.white70,
              valueIndicatorColor: Colors.blue,
              thumbColor: Colors.white,
              overlayColor: Colors.blueAccent,
            ),
            child: new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(2)),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    mMinGasFee.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: ScreenUtil().setSp(2.3),
                    ),
                  ),
                  new Expanded(
                      child: new Slider(
                    min: mMinGasFee ?? 0,
                    max: mMaxGasFee ?? 0,
                    onChanged: (double value) {
                      setState(() {
                        mGasFeeValue = Utils.formatDouble(value, precision: precision);
                      });
                    },
                    divisions: 100,
                    //Don’t want to show scales and bubbles, just delete this attribute, experiment by yourself
                    label: '$mGasFeeValue',
                    value: mGasFeeValue,
                  )),
                  new Text(
                    mMaxGasFee.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: ScreenUtil().setSp(2.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gaps.scaleVGap(1),
        Container(
          color: Colors.transparent,
          child: GestureDetector(
              onTap: () async {
                setState(() {
                  isShowExactGas = !isShowExactGas;
                  if (isShowExactGas) {
                    arrowIcon = arrowDownIcon;
                  } else {
                    arrowIcon = arrowUpIcon;
                  }
                });
              },
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    width: ScreenUtil().setWidth(75),
                    child: Text(
                      translate('high_setting').toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontSize: ScreenUtil().setSp(2.5),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(1)),
                    child: Image.asset(arrowIcon),
                  ),
                ],
              )),
        ),
        Gaps.scaleVGap(5),
      ],
    ));
  }

  Widget _buildHideDetailWidget() {
    return isShowExactGas
        ? AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isShowExactGas ? 1.0 : 0.0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(40),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    translate('gas_price').toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  width: ScreenUtil().setWidth(40),
                                  child: Text(
                                    Utils.formatDouble(mGasPriceValue, precision: precision).toString() + " wei",
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.pink,
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: Colors.white,
                            inactiveTrackColor: Colors.white70,
                            valueIndicatorColor: Colors.grey,
                            thumbColor: Colors.white,
                            overlayColor: Colors.pink,
                          ),
                          child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  mMinGasPrice.toString() + Gwei,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                                new Expanded(
                                    child: new Slider(
                                  min: mMinGasPrice ?? 0,
                                  max: mMaxGasPrice ?? 0,
                                  onChanged: (double value) {
                                    setState(() {
                                      mGasPriceValue = value;
                                      mGasFeeValue = mGasPriceValue * mGasLimitValue / eth2gasUnit;
                                    });
                                  },
                                  divisions: 100,
                                  //Don’t want to show scales and bubbles, just delete this attribute, experiment by yourself
                                  label: '$mGasPriceValue',
                                  value: mGasPriceValue,
                                )),
                                new Text(
                                  mMaxGasPrice.toString() + Gwei,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(40),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    translate('gas_limit').toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  width: ScreenUtil().setWidth(40),
                                  child: Text(
                                    mGasLimitValue.toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: ScreenUtil().setSp(2.5),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.pink,
                            activeTickMarkColor: Colors.white,
                            inactiveTickMarkColor: Colors.white,
                            inactiveTrackColor: Colors.white70,
                            valueIndicatorColor: Colors.grey,
                            thumbColor: Colors.white,
                            overlayColor: Colors.pink,
                          ),
                          child: new Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  mMinGasLimit.toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                                new Expanded(
                                    child: new Slider(
                                  min: mMinGasLimit ?? 0,
                                  max: mMaxGasLimit ?? 0,
                                  onChanged: (double value) {
                                    setState(() {
                                      mGasLimitValue = value;
                                      mGasFeeValue = mGasPriceValue * mGasLimitValue / eth2gasUnit;
                                    });
                                  },
                                  divisions: 100,
                                  //Don’t want to show scales and bubbles, just delete this attribute, experiment by yourself
                                  label: '$mGasLimitValue',
                                  value: mGasLimitValue,
                                )),
                                new Text(
                                  mMaxGasLimit.toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: ScreenUtil().setSp(2.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            translate('extend_msg'),
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: ScreenUtil().setSp(3),
                            ),
                          ),
                        ),
                        Gaps.scaleVGap(2),
                        Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(13),
                          child: TextField(
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: translate('hint_extend_msg_option'),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                fontSize: ScreenUtil().setSp(3),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(1.0),
                                ),
                              ),
                            ),
                            controller: _backupMsgController,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Gaps.scaleHGap(1);
  }

  Widget _buildToAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('receive_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(13),
                  child: TextField(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: ScreenUtil().setSp(3.5),
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setHeight(3),
                        right: ScreenUtil().setWidth(10),
                        top: ScreenUtil().setHeight(5),
                        bottom: ScreenUtil().setHeight(5),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        height: ScreenUtil().setHeight(40),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                      hintText: translate('pls_input_receive_address'),
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontSize: ScreenUtil().setSp(3),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(1.0),
                        ),
                      ),
                    ),
                    controller: _toAddressController,
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  //width: ScreenUtil.getInstance().setWidth(13),
                  alignment: Alignment.bottomRight,
                  height: ScreenUtil().setHeight(12),
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(1),
                    right: ScreenUtil().setWidth(1),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      var status = await Permission.camera.status;
                      if (status.isGranted) {
                        _scanQrContent();
                      } else {
                        Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
                        if (statuses[Permission.camera] == PermissionStatus.granted) {
                          _scanQrContent();
                        } else {
                          Fluttertoast.showToast(msg: translate("camera_permission_deny"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
                        }
                      }
                    },
                    icon: Image.asset("assets/images/ic_scan.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scanQrContent() async {
    try {
      String qrResult = await QrScanUtil.instance.qrscan();
      setState(() {
        _toAddressController.text = qrResult.toString();
      });
    } catch (e) {
      Logger().e("TransferEthPage", "qrscan appear unknow error===>" + e.toString());
      Fluttertoast.showToast(msg: translate('unknown_error_in_scan_qr_code'), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
    }
  }

  Widget _buildValueWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('transaction_amount'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            height: ScreenUtil().setHeight(13),
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(101, 98, 98, 0.50),
                filled: true,
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(2), top: ScreenUtil().setHeight(3.5), bottom: ScreenUtil().setHeight(3.5)),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(3),
                ),
                hintText: translate('pls_input_transaction_amount'),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontSize: ScreenUtil().setSp(3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(1.0),
                  ),
                ),
              ),
              controller: _txValueController,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[0-9.]")), //Enter only numbers or decimal point.
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferBtnWidget() {
    return GestureDetector(
      onTap: () async {
        ProgressDialog.showProgressDialog(context, translate("check_data_format"));
        var verifyTxInfoResult = await _verifyTransferInfo();
        if (!verifyTxInfoResult) {
          NavigatorUtils.goBack(context);
          return;
        }
        var verifyNonceResult = await _verifyNonce();
        NavigatorUtils.goBack(context);
        if (verifyNonceResult) {
          _showPwdDialog(context);
        }
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil().setWidth(41),
        height: ScreenUtil().setHeight(9),
        color: Color.fromRGBO(26, 141, 198, 0.20),
        child: FlatButton(
          child: Text(
            translate('click_to_transfer'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0.03,
            ),
          ),
        ),
      ),
    );
  }

  void _showPwdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PwdDialog(
          title: translate('wallet_pwd').toString(),
          hintContent: translate('input_pwd_hint_detail').toString(),
          hintInput: translate('input_pwd_hint').toString(),
          onPressed: (String pwd) async {
            String walletId = await Wallets.instance.getNowWalletId();
            Map result = await Wallets.instance.ethTxSign(
                walletId,
                Chain.chainTypeToInt(chainType),
                fromAddress,
                _toAddressController.text.toString(),
                contractAddress ?? "",
                _txValueController.text,
                _backupMsgController.text,
                Uint8List.fromList(pwd.codeUnits),
                mGasPriceValue.toInt().toString(),
                mGasLimitValue.toInt().toString(),
                nonce,
                decimal: decimal);
            if (result["status"] != null && result["status"] == 200) {
              Fluttertoast.showToast(msg: translate("sign_success_and_uploading"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
              NavigatorUtils.goBack(context);
              sendRawTx2Chain(result["ethSignedInfo"].toString());
            } else {
              Fluttertoast.showToast(msg: translate("sign_failure_check_pwd"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 6);
              NavigatorUtils.goBack(context);
            }
          },
        );
      },
    );
  }

  void sendRawTx2Chain(String rawTx) async {
    ProgressDialog.showProgressDialog(context, translate("tx_sending"));
    String txHash = await sendRawTx(Wallets.instance.nowWallet.nowChain.chainType, rawTx);
    Logger().d("broadcast txHash is ===>", txHash);
    if (txHash != null && txHash.trim() != "" && txHash.startsWith("0x")) {
      Fluttertoast.showToast(msg: translate("tx_upload_success"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
    } else {
      Fluttertoast.showToast(msg: translate("tx_upload_failure"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
    }
    {
      const timeout = Duration(seconds: 5);
      Timer(timeout, () {
        Navigator.pop(context); //Let the showProgressDialog popup box display for at least two seconds
        NavigatorUtils.goBack(context);
      });
    }
  }

  Future<bool> _verifyNonce() async {
    nonce = await loadTxAccount(fromAddress, chainType);
    if (nonce == null || nonce.trim() == "") {
      Fluttertoast.showToast(msg: translate("nonce_is_wrong"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
      NavigatorUtils.goBack(context);
      return false;
    }
    return true;
  }

  Future<bool> _verifyTransferInfo() async {
    if (_toAddressController.text.trim() == "") {
      Fluttertoast.showToast(msg: translate('to_address_null').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
      return false;
    }

    if (!Utils.checkByEthAddressFormat(_toAddressController.text)) {
      Fluttertoast.showToast(msg: translate("to_address_format_wrong"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
      return false;
    }

    if (_txValueController.text.trim() == "" || double.parse(_txValueController.text.trim()) <= 0) {
      Fluttertoast.showToast(msg: translate('tx_value_is_0').toString(), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
      return false;
    }
    //Determine if the balance is greater than the transfer amount
    List displayDigitsList = Wallets.instance.nowWallet.nowChain.digitsList;
    for (var i = 0; i < displayDigitsList.length; i++) {
      if (digitBalance == null &&
          contractAddress != null &&
          contractAddress.trim() != "" &&
          displayDigitsList[i].contractAddress != null &&
          (displayDigitsList[i].contractAddress.toLowerCase() == contractAddress.toLowerCase())) {
        digitBalance = await loadErc20Balance(
            Wallets.instance.nowWallet.nowChain.chainAddress, displayDigitsList[i].contractAddress, Wallets.instance.nowWallet.nowChain.chainType);
        break;
      }
    }
    if (_txValueController.text.isNotEmpty) {
      try {
        if (double.parse(digitBalance) < double.parse(_txValueController.text)) {
          Fluttertoast.showToast(msg: translate('balance_is_less'));
          return false;
        }
      } catch (e) {
        Fluttertoast.showToast(msg: translate('unknown_in_value'));
        return false;
      }
    }
    ethBalance = await loadEthBalance(Wallets.instance.nowWallet.nowChain.chainAddress, Wallets.instance.nowWallet.nowChain.chainType);
    Logger().d("ethBalance is ===> ", ethBalance.toString() + "|| digitBalance===>" + digitBalance.toString());
    if (ethBalance.isNotEmpty) {
      try {
        if (double.parse(ethBalance) <= 0) {
          Fluttertoast.showToast(msg: translate("not_enough_for_gas"));
          return false;
        }
      } catch (e) {
        Fluttertoast.showToast(msg: translate("eth_balance_error") + e.toString());
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: translate("check_gas_state_failure"));
      return false;
    }
    return true;
  }
}
