import 'package:area_network_device_scanner/config/strings.dart';

class LocalInfo{
  Set<String> ips;
  String wifiName;

  LocalInfo(this.ips, this.wifiName);

  static LocalInfo unknownInfo(){
    return LocalInfo({Status.UNKNOWN}, Status.UNKNOWN);
  }
}