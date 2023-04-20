import 'dart:async';

import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/scan_tasks_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_card.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_list.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/refresh_btn.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerState {

  // cache
  ScanTasks tasks = ScanTasks();
  Stream<PingResult> scanStream = const Stream.empty();
  StreamSubscription<PingResult>? scanSub;
  List<PingResult> scanResults = [];
  int deviceNum = 0;
  Map<String,String> arpCache = {};
  // 本地信息 cache
  Widget localInfo = ConstWidgets.EMPTY;
  Set<String> localIps = {Status.UNKNOWN};
  String localWifiName = Status.UNKNOWN;
  // input cache
  String currInput = "";
  // 设备列表 for view
  Widget deviceListView = ConstWidgets.EMPTY_TEXT;
  // status
  String status = ""; // main status
  bool isScanning = false; // scan status
  Widget refreshBtn = const RefreshBtn(); // btn status for view

  ScannerState() {
    refreshAll();
  }

  // 刷新数据
  refresh(){
    // cache
    tasks = ScanTasks();
    scanStream = const Stream.empty();
    scanSub = null;
    scanResults = [];
    status = "Tap to scan";
    deviceNum = 0;
    arpCache = {};
    // view
    deviceListView = ConstWidgets.EMPTY_TEXT;
    refreshBtn = const RefreshBtn();
    notScanning();
    if (kDebugMode) {
      print("state refreshed");
    }
  }

  refreshAll(){
    refresh();
    currInput = "";
  }

  setStatus(String status) => this.status = status;

  scanning(){
    isScanning = true;
    refreshBtn = const ScanningRefreshBtn();
  }
  notScanning(){
    isScanning = false;
    refreshBtn = const RefreshBtn();
  }

  // 获取本地ip
  String getLocalIpsAsString(){
    if(localIps.contains(Status.UNKNOWN)) {
      return Status.DEF_IP;
    }
    String res = localIps.toString();
    return res.substring(1,res.length-1);
  }

  // 刷新arp列表
  void refreshArpCache() async => arpCache = await ArpApi.loadArpCache();

  // 更新列表
  void updateDeviceResult(PingResult data){
    if(localIps.contains(data.ip))return;
    deviceNum++;
    scanResults.add(data);
    deviceListView = DeviceListView(
      data: scanResults,
    );
  }

}