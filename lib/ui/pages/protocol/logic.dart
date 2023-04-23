import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/pages/markdown_alert/logic.dart';
import 'package:area_network_device_scanner/ui/pages/protocol/view.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class ProtocolLogic extends GetxController {
  final ProtocolState state = ProtocolState();

  static showProtocolPage(BuildContext context){
    ProtocolState.getProtocolStatus()
        .then((isShown) {
      if(!isShown){
        showDialog(
            barrierDismissible: false, //点击空白是否退出
            context: context,
            builder: (context) {
              // disable back button
              return WillPopScope(
                child: const ProtocolPage(),
                onWillPop: () {
                  return Future.value(false);
                },
              );
            });
      }
    });
  }

  shownProtocol(){
    ConfigValues.CONFIG.saveProtocolStatus(true);
  }

  showUsageProtocol(BuildContext context){
    MarkdownAlertLogic.showMarkdownAlert(context, Paths.USAGE_PROTOCOL_PATH);
  }

  showPrivacyProtocol(BuildContext context){
    MarkdownAlertLogic.showMarkdownAlert(context, Paths.PRIVACY_PROTOCOL_PATH);
  }

}
