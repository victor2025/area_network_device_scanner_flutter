import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logics/scan_logic.dart' as scan_logic;
import 'logics/local_info_logic.dart' as local_info_logic;
import 'state.dart';

class ScannerLogic extends GetxController {
  final ScannerState state = ScannerState();
  final TextEditingController inputController = TextEditingController();

  // 开始扫描
  startScan(){
    refreshDeviceList();
    _scanSync();
    update();
  }

  // 刷新页面
  refreshDeviceList(){
    state.refresh();
    local_info_logic.refreshLocalInfo();
    update();
  }

  // 同步等待扫描
  _scanSync({input = "218.194.50.100"}){
    // 开始扫描操作
    scan_logic.beforeScan();
    // 开始扫描
    Future<List<PingResult>> fPingResults = scan_logic.parseInputAndScanIpWithRange(input);
    // 处理数据，并在页面中展示
    fPingResults.then((pingResults)=>scan_logic.afterScan(pingResults));
  }

}
