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
      elevation: 0,
      backgroundColor: Colors.white, //背景颜色
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)), //设置形状
      title: Text('appInfo'.tr,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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
    double boxSize = MediaQuery.of(context).size.width/2;
    return SizedBox(
      width: boxSize,
      height: boxSize/1.4,
      child: ListView(
        children:[
          _getAppInfo(context),
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
    TextStyle mainStyle = const TextStyle(fontSize: 14);
    TextStyle tapperStyle = const TextStyle(color: Colors.blue);
    return Text.rich(
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



