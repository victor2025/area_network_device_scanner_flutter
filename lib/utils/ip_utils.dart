import 'dart:io';

import 'package:area_network_device_scanner/config/regexp.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/local_info_entity.dart';
import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:network_info_plus/network_info_plus.dart';

class IpUtils{

  // 获取本地信息
  static Future<LocalInfo> getLocalInfo() async{
    Set<String> ip = await getLocalIps();
    String wifiName = await getWifiName();
    return LocalInfo(ip, wifiName);
  }

  static Future<String> getWifiName() async{
    String? wifiName;
    await NetworkInfo().getWifiName().then((value){
      wifiName = value;
    }).catchError((e){
      wifiName = Status.UNKNOWN;
    });
    return wifiName??Status.UNKNOWN;
  }

  static Future<Set<String>> getLocalIps() async{
    Set<String> ipSet = await NetworkUtils.getIpsFromNetworkInterface();
    if(ipSet.isEmpty){
      String? ip = await NetworkInfo().getWifiIP();
      ipSet.add(ip??Status.UNKNOWN);
    }
    return ipSet;
  }

  // 将ip地址转换为数值形式
  static int ip2num(String ip) {
    List<int>? ipNumArr = parseIp(ip);
    // 需要保证ip是合法的
    if(ipNumArr==null)return ip2num("255.255.255.255");
    int res = 0;
    for (int num in ipNumArr!) {
      res<<=8;
      res|=num;
    }
    return res;
  }

  static String num2ip(int num) {
    List<int> numArr = [];
    for(int i = 0; i<4; i++){
      int currNum = num&255;
      num>>>=8;
    numArr.insert(0, currNum);
    }
    return "${numArr[0]}.${numArr[1]}.${numArr[2]}.${numArr[3]}";
  }

  static int ipCompare(String ip1, String ip2){
    int startNum = IpUtils.ip2num(ip1);
    int endNum = IpUtils.ip2num(ip2);
    return startNum-endNum;
  }

  static bool isRangeValid(String start, String end){
    if(!isIpValid(start)||!isIpValid(end))return false;
    return ipCompare(start, end)<=0;
  }

  static String getAreaStart(String ip){
    int lastIdx = ip.lastIndexOf(".");
    return "${ip.substring(0,lastIdx)}.0";
  }

  static String getAreaEnd(String ip){
    int lastIdx = ip.lastIndexOf(".");
    return "${ip.substring(0,lastIdx)}.255";
  }

  // 将ip地址解析为十进制数组
  static List<int>? parseIp(String ip){
    List<String> strList = ip.split('.');
    if(strList.length!=4)return null;
    List<int> res = [];
    try{
      for (String value in strList) {
        int? currNum = int.tryParse(value);
        if(currNum==null||currNum<0||currNum>255)return null;
        res.add(currNum);
      }
      return res;
    }catch(e) {
      return null;
    }
  }

  static bool isIpValid(String ip){
    String? match = Regs.IP.firstMatch(ip)?.group(0);
    return match!=null&&match==ip;
  }

}