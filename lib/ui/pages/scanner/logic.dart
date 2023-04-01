import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logics/device_list_logic.dart';
import 'state.dart';

class ScannerLogic extends GetxController {
  final ScannerState state = ScannerState();

  // 获取arp缓存
  _getArpTable() {}

  startScan(){
    clearDeviceList();
    scanIpRange("113.54.148.0", "113.54.148.168");
    update();
  }

  clearDeviceList(){
    state.refresh();
    update();
  }

  testShow(String str) {
    state.testStr = str;
    update();
  }

}
