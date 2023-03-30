import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/config/regexp.dart';
import 'package:area_network_device_scanner/utils/file_utils.dart';

class LinuxArpGetter extends ArpGetter{

  static const String ARP_PATH = "/proc/net/arp";

  @override
  Future<Map<String, String>> loadArpAsMap() async{
    String arpStr = await loadArpAsString();

    return _parseArpCache(arpStr);
  }

  @override
  Future<String> loadArpAsString() async{
    return FileLoader.loadFileAsString(ARP_PATH);
  }

  Map<String,String> _parseArpCache(String str){
    Map<String,String> res = {};
    List<String> lines = str.split("\n");
    for (var line in lines) {
      if(line.isEmpty)continue;
      // 匹配ip
      String? ip = Regs.IP.firstMatch(line)?.group(0);
      if(ip==null)continue;
      // 匹配mac
      String? mac = Regs.MAC.firstMatch(line)?.group(0);
      if(mac==null)continue;
      // 放入map
      res[ip] = mac;
    }
    return res;
  }

}