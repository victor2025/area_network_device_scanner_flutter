import 'package:dart_ping/dart_ping.dart';

class PingResult{
  late String ip;
  late bool isAccessible;
  late double? rtt;

  PingResult(this.ip, this.isAccessible, this.rtt);

  static PingResult successPing(String ip, double? rtt){
    return PingResult(ip, true, rtt);
  }

  static PingResult failPing(String ip){
    return PingResult(ip, false, null);
  }

  static PingResult parsePingDataList(String ip, List<PingData> dataList){
    if(dataList.isNotEmpty&&dataList.last.summary!.received>0){
      double rtt = 0;
      for(int i = 0; i<dataList.length-1; i++){
        rtt+=dataList[i].response!.time!.inMilliseconds;
      }
      rtt/=(dataList.length-1);
      return successPing(ip, rtt);
    }else{
      return failPing(ip);
    }
  }

  @override
  String toString() {
    return "{ip:$ip,accessible:$isAccessible,rtt:$rtt}";
  }
}