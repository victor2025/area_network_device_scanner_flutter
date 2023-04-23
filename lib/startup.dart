import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';

startup() async{
  // init
  await SPUtil.init();
  ConfigValues.initConfigs();
}