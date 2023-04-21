import 'dart:io';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
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
      title: const Text("应用信息",
        style: TextStyle(
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
      height: boxSize/1.5,
      child: ListView(
        children:[
          _getAppInfo(context),
          const Divider(),
          const Text(
               "by victor2022",
              style: TextStyle(color: Colors.grey,fontSize: 10),
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
              text: "应用说明",
              style: tapperStyle,
              recognizer: TapGestureRecognizer()
                ..onTap=()=>logic.showAppInfo(context)
          ),
          const TextSpan(text: "\n\n",),
          TextSpan(
              text: "使用条款",
              style: tapperStyle,
              recognizer: TapGestureRecognizer()
                ..onTap=()=>logic.showUsageProtocol(context)
          ),
          const TextSpan(text: "\n\n"),
          TextSpan(
              text: "隐私协议",
              style: tapperStyle,
              recognizer: TapGestureRecognizer()
                ..onTap=()=>logic.showPrivacyProtocol(context)
          ),
        ],
        style: mainStyle,
      ),
    );
  }

}



