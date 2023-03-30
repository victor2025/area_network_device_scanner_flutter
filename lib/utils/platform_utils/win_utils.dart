import 'package:area_network_device_scanner/config/regexp.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/utils/command_run_utils.dart';

class WinUtils{

  static Future<String> runPingCommand(String addr) async{
    String script = "ping $addr -w 2000";
    String pingStr = await CommandRunner.runCommand(script);
    return pingStr;
  }

  static PingResult parsePingRes(String addr, String pingStr){
    String? str1 = Regs.WIN_PING_RCVD.firstMatch(pingStr)!.group(0);
    String? rcvdStr = Regs.NUM_REG.firstMatch(str1??"")!.group(0);
    int rcvdNum =  int.parse(rcvdStr??"0");
    // 解析
    int? rtt;
    if(rcvdNum>0){
      String? str2 = Regs.WIN_PING_TIME.firstMatch(pingStr)!.group(0);
      String? rttStr = Regs.NUM_REG.firstMatch(str2??"")!.group(0);
      rtt =  int.parse(rttStr??"0");
    }
    return PingResult(addr, rcvdNum>0, rtt);
  }

}