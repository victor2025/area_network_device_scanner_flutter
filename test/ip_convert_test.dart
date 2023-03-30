import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/foundation.dart';

main(){
  // String ip = "192.168.1.1";
  for(int i = 4294967000; i<=4294967295; i++){
    var ipStr = NetworkUtils.num2ip(i);
    if (kDebugMode) {
      print(ipStr);
    }
  }
}