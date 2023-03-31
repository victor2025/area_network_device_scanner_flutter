
import 'dart:io';

import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/foundation.dart';

class IpScanner{

  // 扫描一个ip区间
  static Future<List<PingResult>> scanIpWithRange(String start, String end) async{
    List<PingResult> res = <PingResult>[];
    // 将起止ip转为数字
    int startNum = NetworkUtils.ip2num(start);
    int endNum = NetworkUtils.ip2num(end);
    // 若起止区间不对，则返回false
    if(startNum>endNum)return res;
    // 开始扫描，若可以访问，则添加到list中
    for(int i = startNum;i<=endNum; i++){
      String currIp = NetworkUtils.num2ip(i);
      _isIpAccessible(currIp)
          .then((value) => value.isAccessible?res.add(value):{});
    }
    return res;
  }

  static Future<PingResult> scanIp(String ip) async{
    return _isIpAccessible(ip);
  }

  // 扫描指定IP地址
  static Future<PingResult> _isIpAccessible(String ip) async{
    late var res;
    switch(Platform.operatingSystem){
      case Platforms.WINDOWS:
        res = await NetworkUtils.isAddressAccessibleByCmd(ip);
        break;
      default:
        res = await NetworkUtils.isAddressAccessible(ip);
    }
    if (kDebugMode) {
      print("$ip : $res");
    }
    return res;
  }

}