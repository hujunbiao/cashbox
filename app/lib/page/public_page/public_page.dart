import 'package:app/global_config/global_config.dart';
import 'package:app/global_config/vendor_config.dart';
import 'package:app/util/sharedpreference_util.dart';
import 'package:app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:scry_webview/scry_webview.dart';

class PublicPage extends StatefulWidget {
  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyAppBar(
            centerTitle: translate('public'),
            backgroundColor: Colors.black12,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg_graduate.png"), fit: BoxFit.fill),
            ),
            child: _buildWebViewWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewWidget() {
    return Container(
      color: Colors.transparent,
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(160),
      child: WebView(
        initialUrl: VendorConfig.publicIpDefaultValue,
        //initialUrl: "http://192.168.1.59:9689/pub.html",
        javascriptMode: JavascriptMode.unrestricted, //JS执行模式 是否允许JS执行
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        javascriptChannels: <JavascriptChannel>[].toSet(),
        onPageFinished: (String url) async {
          var spUtil = await SharedPreferenceUtil.instance;
          var savedLocale = spUtil.getString(GlobalConfig.savedLocaleKey);
          _controller?.evaluateJavascript('nativeLocale("$savedLocale")')?.then((result) {}); //传钱包EEE链地址给DApp记录保存
        }),
    );
  }
}
