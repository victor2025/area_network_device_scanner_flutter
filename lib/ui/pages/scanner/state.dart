import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ScannerState {

  String testStr = "";
  List<Widget> deviceList = [];
  RxInt deviceNum = 0.obs;
  int listIdx = 0;

  String arpCache = "";


  ScannerState() {
    refresh();
  }

  refresh(){
    deviceList = [];
    deviceNum = 0.obs;
    listIdx = 0;
  }

}
