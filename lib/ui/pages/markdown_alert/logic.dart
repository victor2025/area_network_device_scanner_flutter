import 'package:area_network_device_scanner/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';
import 'view.dart';

class MarkdownAlertLogic extends GetxController {
  final MarkdownAlertState state = MarkdownAlertState();

  static showMarkdownAlert(BuildContext context, String assertPath) {
    showDialog(
        barrierDismissible: true, //点击空白是否退出
        context: context,
        builder: (context) => MarkdownAlertPage(assertPath: assertPath,));
  }

  Future<String> loadMarkdownContent(String assertPath) {
    return FileLoader.loadAssetsAsString(assertPath);
  }
}
