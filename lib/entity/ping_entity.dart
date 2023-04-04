import 'package:dart_ping/dart_ping.dart';

class PingResult {
  late String ip;
  late bool isAccessible;
  late double rtt;

  PingResult(this.ip, this.isAccessible, this.rtt);

  static PingResult successPing(String ip, double rtt) {
    return PingResult(ip, true, rtt);
  }

  static PingResult failPing(String ip) {
    return PingResult(ip, false, double.infinity);
  }

  static PingResult parsePingDataList(String ip, List<PingData> dataList) {
    if(dataList.isEmpty)return PingResult.failPing(ip);
    PingSummary? summary = dataList.last.summary;
    if (summary!=null&&summary.received>0) {
        double rtt = 0;
        int rcvdCnt = 0;
        for (int i = 0; i < dataList.length - 1; i++) {
          final PingData currData = dataList[i];
          int? currRtt = currData.response?.time?.inMilliseconds;
          if (currRtt != null) {
            rtt += currRtt;
            rcvdCnt++;
          }
        }
        rtt /= rcvdCnt;
        return successPing(ip, rtt);
      }
    return failPing(ip);
  }

  @override
  String toString() {
    return "{ip:$ip,accessible:$isAccessible,rtt:$rtt}";
  }
}
