import 'package:dart_ping/dart_ping.dart';

class PingResult{
  late String ip;
  late bool isAccessible;
  late int? rtt;

  PingResult(this.ip, this.isAccessible, this.rtt);

  static PingResult successPing(String ip, int? rtt){
    return PingResult(ip, false, rtt);
  }

  static PingResult failPing(String ip){
    return PingResult(ip, false, null);
  }

  static PingResult parsePingData(String ip, PingData data){
    if(data.summary!.received>0){
      return successPing(ip, data.summary?.time?.inMilliseconds);
    }else{
      return failPing(ip);
    }
  }

}