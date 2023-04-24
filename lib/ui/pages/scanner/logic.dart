import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/utils/vibrate_utils.dart';
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
    _refreshLogic();
    // 开始同步扫描
    _scanAsync(state.currInput);
    // 更新页面
    update();
    VibrateUtils.unitVibrate();
  }

  stopScan(){
    _stopScanLogic();
    update();
    VibrateUtils.unitVibrate();
  }

  // 开始扫描
  reScan(){
    _refreshLogic();
    _scanAsync(state.currInput);
    update();
    VibrateUtils.unitVibrate();
  }

  // 刷新页面
  refreshState(){
    _refreshLogic();
    update();
    VibrateUtils.unitVibrate();
  }

  refreshLocalInfo(){
    _refreshLocalInfoLogic();
    update();
  }

  refreshAllState(){
    _refreshAllStateLogic();
    update();
    VibrateUtils.unitVibrate();
  }

  _refreshLogic(){
    state.refresh();
    _stopScanLogic();
    _refreshLocalInfoLogic();
  }


  _stopScanLogic(){
    scanLogic.stopScan();
  }

  _refreshLocalInfoLogic(){
    localInfoLogic.refreshLocalInfo();
  }

  // 刷新全部状态
  _refreshAllStateLogic(){
    state.refreshAll();
    state.setStatus('allClearedStatus'.tr);
    inputController.text = "";
    localInfoLogic.refreshLocalInfo();
  }


  // 异步扫描
  _scanAsync(String input){
    try{
      // 开始扫描操作
      scanLogic.beforeScan(input);
      // 开始扫描，并在扫描完成后展示数据
      scanLogic.doScan();
      // 监听stream并刷新页面
      state.scanSub = state.scanStream
          .listen((event){
          state.updateDeviceResult(event);
          update();
      },
      onDone: (){
        scanLogic.afterScan();
        update();
      });
      // scan timeout
      if(ConfigValues.CONFIG.enableTimeout){
        Future.delayed(
            Duration(milliseconds: ConfigValues.CONFIG.scanTimeout)
        ).then((value) => _stopScanLogic());
      }
    }catch(e){
      // 将错误信息显示到状态中
      state.setStatus(e.toString());
    }
  }

}
