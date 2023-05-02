import 'package:arp_cache_loader/arp_cache_loader.dart';

class ArpApi{

  // 从本地读取arp缓存
  static Future<Map<String,String>> loadArpCache() async{
    return ArpLoader.loadArpCacheAsMap();
  }


}