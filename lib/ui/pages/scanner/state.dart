import 'package:flutter/cupertino.dart';

class ScannerState {

  String testStr = "";
  Widget deviceListWidget = const Placeholder();
  int listIdx = 0;

  String arpCache = "";


  ScannerState() {
    refresh();
  }

  refresh(){
    deviceListWidget = const Placeholder();
    listIdx = 0;
  }

}
