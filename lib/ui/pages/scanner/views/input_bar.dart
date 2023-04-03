
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final logic = Get.find<ScannerLogic>();
final state = logic.state;

Widget getInputBar(){

  String defIp = state.getLocalIp();

  var inputLine = TextField(
    keyboardType: TextInputType.text,
    controller: logic.inputController,
    textAlign: TextAlign.left,
    style: TextStyle(fontSize: 12),
    decoration: InputDecoration(
      hintText: "input ip range you want, default: area range of $defIp",
    ),
  );

  return inputLine;

}