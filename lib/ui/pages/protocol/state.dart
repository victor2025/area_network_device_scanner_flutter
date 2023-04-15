import 'package:area_network_device_scanner/config/values.dart';

class ProtocolState {

  ProtocolState();

  static Future<bool> getProtocolStatus() async {
    if(ConfigValues.isProtocolShown==null) await ConfigValues.loadConfig();
    return ConfigValues.isProtocolShown!;
  }
}
