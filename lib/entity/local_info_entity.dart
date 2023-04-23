import 'package:area_network_device_scanner/config/strings.dart';

class LocalInfo{
  Set<String> ips;

  LocalInfo(this.ips);

  static LocalInfo unknownInfo(){
    return LocalInfo({Status.UNKNOWN});
  }

  @override
  String toString() {
    String temp = ips.toString();
    return temp.substring(1,temp.length-1);
  }
}