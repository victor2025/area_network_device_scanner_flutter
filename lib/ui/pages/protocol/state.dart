import 'package:area_network_device_scanner/config/config_values.dart';

class ProtocolState {

  ProtocolState();

  static Future<bool> getProtocolStatus() async {
    if(ConfigValues.CONFIG.isProtocolShown==null) await ConfigValues.initProtocolStatus();
    return ConfigValues.CONFIG.isProtocolShown!;
  }
}
