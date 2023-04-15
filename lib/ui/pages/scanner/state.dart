import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/refresh_btn.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScannerState {

  // 扫描状态
  String status = "";
  // 当前扫描的缓存
  Future<List<PingResult>>? fScan;
  // 本地信息
  Widget localInfo = ConstWidgets.EMPTY;
  Set<String> localIps = {Status.UNKNOWN};
  String localWifiName = Status.UNKNOWN;
  // 设备列表
  List<Widget> deviceList = [];
  Widget deviceListView = ConstWidgets.EMPTY_TEXT;
  // 设备名称
  int deviceNum = 0;
  // arp缓存
  Map<String,String> arpCache = {};
  // 按键
  bool isScanning = false;
  // 输入缓存
  String currInput = "";
  // 按键
  Widget refreshBtn = const RefreshBtn();

  ScannerState() {
    refreshAll();
  }

  // 刷新数据
  refresh(){
    status = "Tap to scan";
    deviceList = [];
    deviceListView = ConstWidgets.EMPTY_TEXT;
    deviceNum = 0;
    arpCache = {};
    refreshBtn = const RefreshBtn();
    fScan = null;
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

}