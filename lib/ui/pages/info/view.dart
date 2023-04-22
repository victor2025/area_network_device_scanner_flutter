import 'package:area_network_device_scanner/config/values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(InfoLogic());

    var dialog = AlertDialog(
      backgroundColor: Colors.white, //背景颜色
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)), //设置形状
      title: Text('appInfo'.tr,
        style: StyleConfigs.alertTitleStyle,
      ),
      content: InfoContent(
        logic: logic,
      ),
    );
    return dialog;
  }
}

class InfoContent extends StatelessWidget {
  const InfoContent({Key? key, required this.logic}) : super(key: key);

  final InfoLogic logic;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height/5;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children:[
          Expanded(child: _getAppInfo(context)),
          const Divider(),
          Container(
            alignment: Alignment.bottomLeft,
            child: _getVersionBox()
          ),
        ]
      )
    );
  }

  Widget _getAppInfo(BuildContext context){
    TextStyle mainStyle = const TextStyle(fontSize: 15);
    TextStyle tapperStyle = const TextStyle(color: Colors.blue);

    var text = Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: 'appIntro'.tr,
              style: tapperStyle,
              recognizer: TapGestureRecognizer()
                ..onTap=()=>logic.showAppInfo(context)
          ),
          const TextSpan(text: "\n\n",),
          TextSpan(
              text: 'usageProtocol'.tr,
              style: tapperStyle,
              recognizer: TapGestureRecognizer()
                ..onTap=()=>logic.showUsageProtocol(context)
          ),
          const TextSpan(text: "\n\n"),
          TextSpan(
              text: 'privacyProtocol'.tr,
              style: tapperStyle,
              recognizer: TapGestureRecognizer()
                ..onTap=()=>logic.showPrivacyProtocol(context)
          ),
          const TextSpan(text: "\n"),
        ],
        style: mainStyle,
      ),
    );

    return Container(
      alignment: Alignment.topLeft,
      child: ListView(
        children: [text],
      ),
    );
  }

  FutureBuilder<String> _getVersionBox(){
    return FutureBuilder(
      future: logic.getVersionStr(),
      builder: (c,s){
        final String str = s.data??"";
        return Text(
          str,
          style: const TextStyle(color: Colors.grey,fontSize: 10),
        );
      },
    );
  }

}



