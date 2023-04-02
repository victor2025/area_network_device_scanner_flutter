import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/api/arp_api/src/linux.dart';
import 'package:area_network_device_scanner/utils/command_run_utils.dart';

class AndroidArpGetter extends ArpApi{
  static const String ARP_CMD = "ip neigh";
  static const String ARP_PATH = LinuxArpGetter.ARP_PATH;

  @override
  Future<Map<String, String>> loadArpAsMap() async{
    String arpStr = await loadArpAsString();
    return parseArpCache(arpStr);
  }

  @override
  Future<String> loadArpAsString() async{
    return await CommandRunner.runCommand(ARP_CMD);
  }

}