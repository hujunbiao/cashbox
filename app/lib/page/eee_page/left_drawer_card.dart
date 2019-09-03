import 'package:app/model/chain.dart';
import 'package:app/model/wallet.dart';
import 'package:app/model/wallets.dart';
import 'package:app/widgets/my_separator_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';

class LeftDrawerCard extends StatefulWidget {
  @override
  _LeftDrawerCardState createState() => _LeftDrawerCardState();
}

class _LeftDrawerCardState extends State<LeftDrawerCard> {
  List<Wallet> walletList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    walletList = [];
    walletList =
        await Wallets.instance.loadAllWalletList(); //在首页加载后，已经掉过接口了,拿缓存就行
    setState(() {
      this.walletList = walletList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setHeight(160),
      color: Colors.white,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Gaps.scaleVGap(ScreenUtil().setHeight(1)),
            Container(
              child: _drawerAction(),
            ),
            Gaps.scaleVGap(ScreenUtil().setHeight(1)),
            Container(
              height: ScreenUtil().setHeight(82),
              child: SingleChildScrollView(
                child: Wrap(
                  children: _drawerWalletList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawerAction() {
    return Container(
      height: ScreenUtil().setHeight(63.75),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_mine.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '我的',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.minePage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_public.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '公告',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.publicPage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_public.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  'Dapp',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.dappDemoPage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_add.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '添加钱包',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.createWalletNamePage);
                }),
          ),
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(12),
            child: new ListTile(
                leading: new Image.asset(
                  "assets/images/ic_nav_import.png",
                  width: ScreenUtil().setWidth(6),
                  height: ScreenUtil().setWidth(6),
                ),
                title: new Text(
                  '导入钱包',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  NavigatorUtils.push(context, Routes.importWalletPage);
                }),
          ),
        ],
      ),
    );
  }

  List<Widget> _drawerWalletList() {
    List<Widget> walletListWidget = List.generate(walletList.length, (index) {
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                child: GestureDetector(
                  onTap: () async {
                    print("wallet index is===> " + walletList[index].walletId);

                    var isSuccess = await Wallets.instance
                        .setNowWallet(walletList[index].walletId);
                    if (isSuccess) {
                      NavigatorUtils.push(context, Routes.eeePage,
                          clearStack: true);
                    } else {
                      Fluttertoast.showToast(msg: "钱包切换失败，请重新打开切换");
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Gaps.scaleVGap(1),
                      Container(
                        width: ScreenUtil().setWidth(60),
                        height: ScreenUtil().setWidth(13),
                        alignment: Alignment.centerLeft,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: ScreenUtil().setWidth(25),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    walletList[index] != null
                                        ? walletList[index].walletName
                                        : "",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(18),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(3)),
                                  child: Text(
                                    "0", //walletList[index].money,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(1)),
                                  child: Image.asset(
                                      "assets/images/ic_nav_enter.png"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: _buildChainListCard(walletList[index]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(52),
                height: ScreenUtil().setHeight(0.05),
                child: CustomPaint(
                  foregroundPainter: MySeparatorLine(
                    lineColor: Colors.blueAccent,
                    width: ScreenUtil().setWidth(52),
                  ),
                ),
              )
            ],
          ));
    });
    return walletListWidget;
  }

  List<Widget> _buildChainListCard(Wallet wallet) {
    List<Widget> chainsList = List.generate(wallet.chainList.length, (index) {
      Chain nowChain = wallet.chainList[index];
      return Container(
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(7.5),
        width: ScreenUtil().setWidth(10),
        child: Text(
          nowChain.chainTypeToValue(nowChain.chainType),
          style: TextStyle(color: Color(0xFF57CAF2), fontSize: 12),
        ),
      );
    });
    return chainsList;
  }
}
