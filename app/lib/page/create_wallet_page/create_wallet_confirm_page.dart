import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';

class CreateWalletConfirmPage extends StatefulWidget {
  @override
  _CreateWalletConfirmPageState createState() =>
      _CreateWalletConfirmPageState();
}

class _CreateWalletConfirmPageState extends State<CreateWalletConfirmPage> {
  List<String> mnemonicList = [
    "victory",
    "october",
    "off",
    "drink ",
    "shallow",
    "actual",
    "stone",
    "decade",
    "victory",
    "october",
    "off",
    "drink "
  ];
  var verifyString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_graduate.png"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          centerTitle: "添加钱包",
          backgroundColor: Colors.transparent,
        ),
        body: _buildConfirmMnemonic(),
      ),
    );
  }

  Widget _buildConfirmMnemonic() {
    return Container(
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(78.75),
        height: ScreenUtil().setWidth(160),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(10.75),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "备份助记词",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(1.75),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Text(
                "以下是钱包的助记词，抄写下来并导出至安全的地方存放。一旦丢失，无法找回。",
                textAlign: TextAlign.left,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.03,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5.5),
            ),
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(78.75),
              height: ScreenUtil().setHeight(40),
              color: Color.fromRGBO(255, 255, 255, 0.06),
              child: Container(
                alignment: Alignment.center,
                child: _buildVerifyInputMnemonic(),
              ),
            ),
            Wrap(
              children: _buildRandomMnemonicBtn(),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10.5),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: ScreenUtil().setWidth(41),
              height: ScreenUtil().setHeight(9),
              color: Color.fromRGBO(26, 141, 198, 0.20),
              child: FlatButton(
                onPressed: () {
                  print("clicked the add wallet btn");
                  //Application.router.navigateTo(context, "createwalletconfirmpage");
                },
                child: Text(
                  "助记词确认验证",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.03,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyInputMnemonic() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: Text(
        this.verifyString,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          wordSpacing: 5,
        ),
        maxLines: 3,
      ),
    );
  }

  List<Widget> _buildRandomMnemonicBtn() {
    List<Widget> randomWidgetList = List.generate(mnemonicList.length, (index) {
      return Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(18.75),
        child: FlatButton(
          child: Text(
            mnemonicList[index].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              fontSize: 12,
            ),
          ),
          onPressed: () {
            setState(() {
              this.verifyString =
                  this.verifyString + mnemonicList[index].toString() + " ";
              mnemonicList.removeAt(index);
            });
          },
        ),
      );
    });
    return randomWidgetList;
  }
}