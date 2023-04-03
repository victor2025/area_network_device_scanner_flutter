import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/local_info_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logics/local_info_logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_list.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

// 异步扫描IP范围，并生成列表
void scanIpRangeAsync() async{
  String ip = state.getLocalIp();
  // 开始扫描
  List<Widget> list = state.deviceList;
  // 读取arp表
  state.refreshArpCache();
  // 将起止ip转为数字
  int startNum = IpUtils.ip2num(ip)&IpUtils.ip2num("255.255.255.0");
  int endNum = startNum+255;
  if (startNum > endNum) return;
  // 开始扫描，并添加futureBuilder到list中
  for (int i = startNum; i <= endNum; i++) {
    list.add(getPingFutureBuilder(IpUtils.num2ip(i)));
  }
}
