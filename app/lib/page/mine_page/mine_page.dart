import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/resources.dart';
import '../../routers/application.dart';
import '../../routers/routers.dart';
import '../../routers/fluro_navigator.dart';
import '../../res/styles.dart';
import '../../widgets/app_bar.dart';
import 'package:app/util/qr_scan_util.dart';
import '../../widgets/list_item.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "我的",
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(160),
          alignment: Alignment.center,
          child: Column(children: <Widget>[
            Gaps.scaleVGap(5),
            GestureDetector(
              onTap: () {
                print("click 货币管理");
              },
              child: Container(
                width: ScreenUtil().setWidth(90),
                height: ScreenUtil().setHeight(13.5),
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                      child: Text(
                        "货币管理",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(90),
                      height: ScreenUtil().setHeight(13.5),
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.only(right: ScreenUtil().setWidth(13.5)),
                      child: Text("\$USD",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(90),
                      height: ScreenUtil().setHeight(13.5),
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(7)),
                      child: Image.asset("assets/images/ic_enter.png"),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("click 钱包管理");
                NavigatorUtils.push(context, Routes.walletManagerListPage);
              },
              child: ItemOfListWidget(
                leftText: "钱包管理",
              ),
            ),
            GestureDetector(
              onTap: () {
                print("click 语言选择");
              },
              child: ItemOfListWidget(
                leftText: "语言选择",
              ),
            ),
            GestureDetector(
              onTap: () {
                NavigatorUtils.push(context, Routes.aboutUsPage);
              },
              child: ItemOfListWidget(
                leftText: "关于我们",
              ),
            ),
            GestureDetector(
              onTap: () {
                print("click 版本更新");
              },
              child: ItemOfListWidget(
                leftText: "版本更新",
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
