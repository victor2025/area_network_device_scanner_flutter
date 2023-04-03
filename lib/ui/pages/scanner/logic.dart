import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logics/scan_logic.dart' as scan_logic;
import 'logics/local_info_logic.dart' as local_info_logic;
import 'state.dart';

class ScannerLogic extends GetxController {
  final ScannerState state = ScannerState();
  final TextEditingController inputController = TextEditingController();

  // 获取输入并扫描
  getInputAndStartScan(){
    // 获取输入
    state.currInput = inputController.text;
    // 刷新
    refreshState();
    // 开始同步扫描
    _scanSync(state.currInput);
    update();
  }

  // 开始扫描
  reScan(){
    refreshState();
    _scanSync(state.currInput);
    update();
  }

  // 刷新页面
  refreshState(){
    state.refresh();
    local_info_logic.refreshLocalInfo();
    update();
  }

  // 刷新全部状态
  refreshAllState(){
    state.refreshAll();
    local_info_logic.refreshLocalInfo();
    update();
  }

  // 同步等待扫描
  _scanSync(String input){
    // 开始扫描操作
    input = scan_logic.beforeScan(input);
    // 开始扫描，并在扫描完成后展示数据
    scan_logic
        .parseInputAndScanIpWithRange(input)
        .then((pingResults)=>scan_logic.afterScan(pingResults));
  }

}
