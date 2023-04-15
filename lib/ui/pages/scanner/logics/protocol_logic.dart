import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/state.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/protocol_dialog.dart';
import 'package:area_network_device_scanner/utils/file_utils.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/material.dart';

class ProtocolLogic{

  static const String _PROTOCOL_PATH = "docs/privacy-agreement.md";
  final ScannerState state;

  ProtocolLogic(this.state);

  showProtocolDialog(BuildContext context) async{
    if(!state.isProtocolShown){
      state.isProtocolShown = true;
      await showDialog(
          barrierDismissible: false, //点击空白是否退出
          context: context,
          builder: (context) {
            return ProtocolDialog(protocolLogic: this);
          });
    }
  }

  shownProtocol(){
    SPUtil.save(PreferenceKeys.PROTOCOL, true);
  }

  Future<String> loadPrivacyProtocol(){
    return FileLoader.loadFileAsString(_PROTOCOL_PATH);
  }

}