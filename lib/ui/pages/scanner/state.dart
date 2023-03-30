import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ScannerState {

  String testStr = "";
  Widget deviceListWidget = Container();
  RxInt deviceNum = 0.obs;
  int listIdx = 0;

  String arpCache = "";


  ScannerState() {
    refresh();
  }

  refresh(){
    deviceListWidget = Container();
    deviceNum = 0.obs;
    listIdx = 0;
  }

}
