import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
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
    // state.deviceListWidget = DeviceList(isOn:true, start: "113.54.148.0", end:"113.54.148.168");
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

  scanIpRange(String start, String end){
    List<Widget> list = state.deviceList;
    // 将起止ip转为数字
    int startNum = NetworkUtils.ip2num(start);
    int endNum = NetworkUtils.ip2num(end);
    if (startNum > endNum) return list;
    // 开始扫描，若可以访问，则添加到list中
    for (int i = startNum; i <= endNum; i++) {
      list.add(getPingFutureBuilder(NetworkUtils.num2ip(i)));
    }
  }
}
