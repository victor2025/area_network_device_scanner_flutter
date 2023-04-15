import 'package:area_network_device_scanner/entity/scan_tasks_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logics/scan_logic.dart';
import 'logics/local_info_logic.dart';
import 'state.dart';

class ScannerLogic extends GetxController {

  final ScannerState state = ScannerState();
  final TextEditingController inputController = TextEditingController();
  late final ScanLogic scanLogic;
  late final LocalInfoLogic localInfoLogic;

  ScannerLogic(){
    scanLogic = ScanLogic(state);
    localInfoLogic = LocalInfoLogic(state);
  }


  // 获取输入并扫描
  getInputAndStartScan(){
    // 获取输入
    state.currInput = inputController.text;
    // 刷新
    refreshState();
    // 开始同步扫描
    _scanSync(state.currInput);
    // 更新页面
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
    localInfoLogic.refreshLocalInfo();
    update();
  }

  // 刷新全部状态
  refreshAllState(){
    state.refreshAll();
    localInfoLogic.refreshLocalInfo();
    update();
  }


  // 同步等待扫描
  _scanSync(String input){
    try{
      // 开始扫描操作
      ScanTasks tasks = scanLogic.beforeScan(input);
      // 开始扫描，并在扫描完成后展示数据
      state.fScan = scanLogic.startScanTask(tasks);
      state.fScan?.then((pingResults){
            scanLogic.afterScan(pingResults);
            update();
      });
    }catch(e){
      // 将错误信息显示到状态中
      state.setStatus(e.toString());
    }
  }


}
