import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/utils/command_run_utils.dart';

class WinArpGetter extends ArpGetter{

  static const String ARP_CMD = "arp -a";

  @override
  Future<String> loadArpAsString() async{
    return await CommandRunner.runCommand(ARP_CMD);
  }

  @override
  Future<Map<String, String>> loadArpAsMap() async{
    Map<String,String> res = {};
    String arpStr = await loadArpAsString();
    // 将字符串解析为map
    _parseArpString(arpStr, res);
    return res;
  }

  _parseArpString(String str, Map<String,String> map){
    map["0"] = str;
  }





}