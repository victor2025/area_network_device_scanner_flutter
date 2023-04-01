import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/entity/mac_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_list.dart';
import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

// 扫描IP范围吗，并生成列表
void scanIpRange(String start, String end){
  List<Widget> list = state.deviceList;
  // 载入arp缓存
  refreshArpCache();
  // 将起止ip转为数字
  int startNum = NetworkUtils.ip2num(start);
  int endNum = NetworkUtils.ip2num(end);
  if (startNum > endNum) return list;
  // 开始扫描，若可以访问，则添加到list中
  for (int i = startNum; i <= endNum; i++) {
    list.add(getPingFutureBuilder(NetworkUtils.num2ip(i)));
  }
}

// 刷新arp列表
void refreshArpCache() async{
  state.arpCache = await ArpGetter.loadArpCache();
}

// MacResult getMacFromArp(ip){
//   if(state.arpCache==null)return
// }