import 'package:area_network_device_scanner/config/strings.dart';
import 'package:flutter/material.dart';
import 'package:area_network_device_scanner/utils/vibrate_utils.dart';
import 'package:get/get.dart';

import 'state.dart';
import 'view.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  static showSettingPage(BuildContext context) {
    VibrateUtils.unitVibrate();
    showDialog(
        barrierDismissible: true, //点击空白是否退出
        context: context,
        builder: (context)=>const SettingPage()
    );
  }

  refreshState(){
    state.loadConfigs();
  }

  tapShowCompany(){
    state.switchShowCompany();
    update();
    VibrateUtils.unitVibrate();
  }

  tapThreadCountDown(){
    state.threadNumberCountDown();
    update();
    VibrateUtils.unitVibrate();
  }

  tapThreadCountUp(){
    state.threadNumberCountUp();
    update();
    VibrateUtils.unitVibrate();
  }

  tapEnableTimeout(){
    state.switchEnableTimeout();
    update();
    VibrateUtils.unitVibrate();
  }

  tapTimeoutCountDown(){
    state.timeoutCountDown();
    update();
    VibrateUtils.unitVibrate();
  }

  tapTimeoutCountUp(){
    state.timeoutCountUp();
    update();
    VibrateUtils.unitVibrate();
  }

  tapLanguage(){
    state.switchLanguage();
    update();
    VibrateUtils.unitVibrate();
  }

  tapSave(){
    state.saveConfigs();
    update();
    VibrateUtils.unitVibrate();
  }

  tapCancel(){
    update();
    VibrateUtils.unitVibrate();
  }
}
