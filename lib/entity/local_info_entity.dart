import 'package:area_network_device_scanner/config/strings.dart';

class LocalInfo{
  String ip;
  String wifiName;

  LocalInfo(this.ip, this.wifiName);

  static LocalInfo unknownInfo(){
    return LocalInfo(Status.UNKNOWN, Status.UNKNOWN);
  }
}