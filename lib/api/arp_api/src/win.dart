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
    String arpStr = await loadArpAsString();
    // 替换分隔符
    arpStr = arpStr.replaceAll('-', ':');
    // 将字符串解析为map
    return parseArpCache(arpStr);
  }


}