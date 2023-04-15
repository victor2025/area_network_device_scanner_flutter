import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/pages/protocol/view.dart';
import 'package:area_network_device_scanner/utils/file_utils.dart';
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
    ConfigValues.isProtocolShown = true;
    SPUtil.save(PreferenceKeys.PROTOCOL, ConfigValues.isProtocolShown);
  }

  Future<String> loadProtocol() async{
    StringBuffer sb = StringBuffer();
    sb..write(await _loadUserProtocol())
      ..write("\n")
      ..write(await _loadPrivacyProtocol());
    return sb.toString();
  }

  Future<String> _loadUserProtocol(){
    return FileLoader.loadAssetsAsString(Paths.USER_PROTOCOL_PATH);
  }

  Future<String> _loadPrivacyProtocol(){
    return FileLoader.loadAssetsAsString(Paths.PRIVACY_PROTOCOL_PATH);
  }
}
