import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';
import 'view.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  static showSettingPage(BuildContext context) {
    showDialog(
        barrierDismissible: true, //点击空白是否退出
        context: context,
        builder: (context)=>const SettingPage()
    );
  }

  tapShowCompany(){
    state.switchShowCompany();
    update();
  }

  tapThreadCountDown(){
    state.threadNumberCountDown();
    update();
  }

  tapThreadCountUp(){
    state.threadNumberCountUp();
    update();
  }

  tapEnableTimeout(){
    state.switchEnableTimeout();
    update();
  }

  tapTimeoutCountDown(){
    state.timeoutCountDown();
    update();
  }

  tapTimeoutCountUp(){
    state.timeoutCountUp();
    update();
  }

  tapLanguage(){
    state.switchLanguage();
    update();
  }
}
