import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ScannerState {

  // 本地信息
  Widget localInfo = ConstWidgets.EMPTY;
  String localIp = Status.UNKNOWN;
  String localWifiName = Status.UNKNOWN;
  // 设备列表
  List<Widget> deviceList = [];
  // 设备名称
  int deviceNum = 0;
  // arp缓存
  Map<String,String> arpCache = {};



  ScannerState() {
    refresh();
  }

  refresh(){
    deviceList = [];
    deviceNum = 0;
    arpCache = {};
    if (kDebugMode) {
      print("state refreshed");
    }
  }

}
