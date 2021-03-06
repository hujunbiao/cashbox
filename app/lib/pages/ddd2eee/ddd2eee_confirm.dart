import 'dart:async';
import 'dart:typed_data';
import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/net/etherscan_util.dart';
import 'package:app/provide/transaction_provide.dart';
import 'package:app/res/resources.dart';
import 'package:app/routers/fluro_navigator.dart';
import 'package:app/routers/routers.dart';
import 'package:app/util/utils.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:app/widgets/progress_dialog.dart';
import 'package:app/widgets/pwd_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Ddd2EeeConfirmPage extends StatefulWidget {
  @override
  _Ddd2EeeConfirmPageState createState() => _Ddd2EeeConfirmPageState();
}

class _Ddd2EeeConfirmPageState extends State<Ddd2EeeConfirmPage> {
  String fromExchangeAddress = "";
  String toExchangeAddress = "";
  String contractAddress = "";
  String dddAmount = "";
  String eeeAddress = "";
  String gasPrice = "";
  String gasLimit = "";
  String nonce = "";
  int decimal = 18;
  ChainType chainType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initDataConfig();
  }

  void initDataConfig() async {
    fromExchangeAddress = Provider.of<TransactionProvide>(context).fromAddress;
    Config config = await HandleConfig.instance.getConfig();

    switch (Wallets.instance.nowWallet.walletType) {
      //use walletType:in case :nowChain is not eth or eth_test
      case WalletType.TEST_WALLET:
        toExchangeAddress = config.privateConfig.d2eTestNetEthAddress;
        chainType = ChainType.ETH_TEST;
        break;
      case WalletType.WALLET:
        toExchangeAddress = config.privateConfig.d2eMainNetEthAddress;
        chainType = ChainType.ETH;
        break;
    }

    eeeAddress = Provider.of<TransactionProvide>(context).backup;
    dddAmount = Provider.of<TransactionProvide>(context).txValue ?? "0.0";
    gasPrice = Provider.of<TransactionProvide>(context).gasPrice;
    gasLimit = Provider.of<TransactionProvide>(context).gas;
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
          centerTitle: translate('token_exchange'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          child: _buildConfirmExchangeWidget(),
        ),
      ),
    );
  }

  Widget _buildConfirmExchangeWidget() {
    return Container(
      width: ScreenUtil().setWidth(80),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.scaleVGap(4),
            _buildFromEthAddressWidget(),
            Gaps.scaleVGap(5),
            _buildToEthAddressWidget(),
            Gaps.scaleVGap(3),
            _buildEeeTargetAddressWidget(),
            Gaps.scaleVGap(5),
            _buildDddAmountWidget(),
            Gaps.scaleVGap(5),
            _buildGasPriceWidget(),
            Gaps.scaleVGap(5),
            _buildGasLimitWidget(),
            Gaps.scaleVGap(5),
            _buildFinalConfirmWidget(),
            Gaps.scaleVGap(15),
            _buildExchangeBtnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildFromEthAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_from_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              fromExchangeAddress,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToEthAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_to_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              toExchangeAddress,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEeeTargetAddressWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('eee_target_address'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              eeeAddress,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDddAmountWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_ddd_amount'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              dddAmount,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGasPriceWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('gas_price'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              gasPrice,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGasLimitWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('gas_limit'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              gasLimit,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: ScreenUtil().setSp(3.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalConfirmWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              translate('exchange_confirm_instruction'),
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: ScreenUtil().setSp(3),
              ),
            ),
          ),
          Gaps.scaleVGap(2),
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: translate('exchange_confirm_instruction_content_hint1'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.redAccent,
                      fontSize: ScreenUtil().setSp(3),
                      fontStyle: FontStyle.normal,
                    )),
                TextSpan(
                    text: translate('exchange_confirm_instruction_content_hint2'),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.redAccent,
                      fontSize: ScreenUtil().setSp(3),
                      fontStyle: FontStyle.normal,
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeBtnWidget() {
    return GestureDetector(
      onTap: () async {
        ProgressDialog.showProgressDialog(context, translate("check_data_format"));
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
            translate('click_to_exchange'),
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

  Future<bool> _verifyNonce() async {
    nonce = await loadTxAccount(fromExchangeAddress, chainType);
    if (nonce == null || nonce.trim() == "") {
      Fluttertoast.showToast(msg: translate("nonce_is_wrong"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
      return false;
    }
    return true;
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
            Config config = await HandleConfig.instance.getConfig();

            Map result = await Wallets.instance.ethTxSign(
                walletId,
                Chain.chainTypeToInt(chainType),
                fromExchangeAddress,
                toExchangeAddress,
                chainType == ChainType.ETH ? config.privateConfig.dddMainNetCA : config.privateConfig.dddTestNetCA,
                dddAmount,
                eeeAddress,
                Uint8List.fromList(pwd.codeUnits),
                gasPrice,
                gasLimit,
                nonce,
                decimal: decimal);
            if (result != null && result.containsKey("status") && result["status"] == 200) {
              Fluttertoast.showToast(msg: translate("sign_success_and_uploading"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 5);
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
    NavigatorUtils.goBack(context);
    ProgressDialog.showProgressDialog(context, translate("tx_sending"));
    String txHash = await sendRawTx(chainType, rawTx);
    if (txHash != null && txHash.trim() != "" && txHash.startsWith("0x")) {
      Fluttertoast.showToast(msg: translate("tx_upload_success"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
    } else {
      Fluttertoast.showToast(msg: translate("tx_upload_failure"), toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 8);
    }
    {
      const timeout = Duration(seconds: 5);
      Timer(timeout, () {
        Navigator.pop(context); //Let the showProgressDialog popup box display for at least two seconds
        NavigatorUtils.push(context, '${Routes.homePage}?isForceLoadFromJni=false', clearStack: true);
      });
    }
  }
}
