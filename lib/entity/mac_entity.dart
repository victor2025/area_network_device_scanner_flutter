import 'package:area_network_device_scanner/config/strings.dart';

class MacResult{

  String ip;
  String mac;
  String name;

  MacResult(this.ip, {this.mac= Status.UNKNOWN, this.name = Status.UNKNOWN});

  static MacResult unknownResult(String ip){
    return MacResult(ip);
  }

  static MacResult withoutNameResult(String ip, String mac){
    return MacResult(ip, mac: mac, name: Status.UNKNOWN);
  }

  static MacResult withNameResult(String ip, String mac, String name){
    return MacResult(ip, mac: mac, name: name);
  }

  bool hasMac() => mac!=Status.UNKNOWN;

  bool hasName() => name!=Status.UNKNOWN;
}