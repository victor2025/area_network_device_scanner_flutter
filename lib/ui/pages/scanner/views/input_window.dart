import 'dart:async';

import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:flutter/material.dart';
import 'package:area_network_device_scanner/utils/vibrate_utils.dart';
import 'package:get/get.dart';

class InputPage extends StatelessWidget {

  static Future<T?> show<T>(BuildContext context) {
    VibrateUtils.unitVibrate();
    return Navigator.of(context).push(
      PageRouteBuilder(
        // 关键
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return InputPage();
        },
      ),
    );
  }

  InputPage({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ScannerLogic>();
    final state = logic.state;

    // 加个小延迟
    Timer(const Duration(milliseconds: 50), (() {
      focusNode.requestFocus();
    }));

    var inputBox = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 撑起上部分
        Expanded(child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        )),
        Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: TextField(
              controller: logic.inputController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "${'inputTips'.tr} ${state.getLocalIpsAsString()}",
              ),
              style: const TextStyle(fontSize: 12),
              focusNode: focusNode,
              minLines: 3,
              maxLines: 6,
            )),
        Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 8),
            width: double.infinity,
            child: TextButton.icon(
                onPressed: () {
                  VibrateUtils.unitVibrate();
                  Navigator.pop(context, logic.inputController.text);
                  logic.getInputAndStartScan();
                },
                icon: const Icon(Icons.radar),
                label: Text('startScan'.tr))),
      ],
    );


    return Scaffold(
        // 关键
        backgroundColor: Colors.black.withAlpha((255 * 0.4).toInt()),
        body: inputBox);
  }
}