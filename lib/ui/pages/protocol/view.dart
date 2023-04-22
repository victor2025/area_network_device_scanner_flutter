import 'dart:io';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ProtocolPage extends StatelessWidget {
  const ProtocolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProtocolLogic());
    final state = Get.find<ProtocolLogic>().state;

    var agreeBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            logic.shownProtocol();
            Navigator.of(context).pop(true);
          },
          child: Text('agree'.tr)),
    );

    var quitBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            exit(0);
          },
          child: Text('exit'.tr)),
    );

    var actions = Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(child: quitBtn),
            Expanded(child: agreeBtn),
          ],
        )
    );

    var dialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white, //背景颜色
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)), //设置形状
      title: Text('userProtocolTitle'.tr,
        style: StyleConfigs.alertTitleStyle,
      ),
      content: ProtocolContent(
        protocolLogic: logic,
      ),
      actions: [
        actions,
      ],
    );
    return dialog;
  }
}

class ProtocolContent extends StatelessWidget {
  const ProtocolContent({Key? key, required this.protocolLogic}) : super(key: key);

  final ProtocolLogic protocolLogic;

  @override
  Widget build(BuildContext context) {
    double boxSize = MediaQuery.of(context).size.width/2;
    return SizedBox(
      width: boxSize,
      height: boxSize/1.5,
      child: _getUserProtocol(context),
    );
  }


  Widget _getUserProtocol(BuildContext context){
    TextStyle mainStyle = const TextStyle(fontSize: 14);
    TextStyle tapperStyle = const TextStyle(color: Colors.blue);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'userProtocolPrefix'.tr,),
          TextSpan(
            text: 'usageProtocolTitle'.tr,
            style: tapperStyle,
            recognizer: TapGestureRecognizer()
              ..onTap=()=>protocolLogic.showUsageProtocol(context)
          ),
          TextSpan(text: 'and'.tr),
          TextSpan(
            text: 'privacyProtocolTitle'.tr,
            style: tapperStyle,
            recognizer: TapGestureRecognizer()
              ..onTap=()=>protocolLogic.showPrivacyProtocol(context)
          ),
          TextSpan(text: 'userProtocolSuffix'.tr),
        ],
        style: mainStyle,
      ),
    );
  }
}



