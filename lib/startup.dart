import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';

startup() async{
  // init
  await SPUtil.init();
  ConfigValues.loadConfig();
}