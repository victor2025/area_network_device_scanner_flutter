import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/pages/info/view.dart';
import 'package:area_network_device_scanner/ui/pages/markdown_alert/logic.dart';
import 'package:area_network_device_scanner/ui/pages/protocol/view.dart';
import 'package:area_network_device_scanner/utils/file_utils.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class InfoLogic extends GetxController {
  final InfoState state = InfoState();

  static showInfoPage(BuildContext context) {
    showDialog(
        barrierDismissible: true, //点击空白是否退出
        context: context,
        builder: (context)=>const InfoPage()
    );
  }

  Future<String> getVersionStr(){
    return FileLoader.loadAssetsAsString(Paths.VERSION_PATH);
  }

  showAppInfo(BuildContext context){
    MarkdownAlertLogic.showMarkdownAlert(context, Paths.INFO_PATH);
  }

  showUsageProtocol(BuildContext context) {
    MarkdownAlertLogic.showMarkdownAlert(context, Paths.USAGE_PROTOCOL_PATH);
  }

  showPrivacyProtocol(BuildContext context) {
    MarkdownAlertLogic.showMarkdownAlert(context, Paths.PRIVACY_PROTOCOL_PATH);
  }
}
