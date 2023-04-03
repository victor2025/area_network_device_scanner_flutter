import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ScannerState {
  // 扫描状态
  String status = "";
  // 本地信息
  Widget localInfo = ConstWidgets.EMPTY;
  String localIp = Status.UNKNOWN;
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

  ScannerState() {
    refresh();
  }

  // 刷新数据
  refresh(){
    status = "Tap to scan";
    deviceList = [];
    deviceListView = ConstWidgets.EMPTY_TEXT;
    deviceNum = 0;
    arpCache = {};
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

  scanning()=>isScanning = true;
  notScanning()=>isScanning = false;

  // 获取本地ip
  String getLocalIp() => localIp==Status.UNKNOWN?Status.DEF_IP:localIp;

  // 刷新arp列表
  void refreshArpCache() async => arpCache = await ArpApi.loadArpCache();



}