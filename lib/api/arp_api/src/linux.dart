import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/utils/file_utils.dart';

class LinuxArpGetter extends ArpApi{

  static const String ARP_PATH = "/proc/net/arp";

  @override
  Future<Map<String, String>> loadArpAsMap() async{
    String arpStr = await loadArpAsString();
    return parseArpCache(arpStr);
  }

  @override
  Future<String> loadArpAsString() async{
    return FileLoader.loadFileAsString(ARP_PATH);
  }



}