import 'dart:io';

import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/task_manager.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/foundation.dart';

class PingApi {

  // 扫描一个ip区间
  static Future<List<PingResult>> scanIpWithRange(String start, String end) async {
    List<PingResult> res = <PingResult>[];
    // 将起止ip转为数字
    int startNum = IpUtils.ip2num(start);
    int endNum = IpUtils.ip2num(end);
    // 若起止区间不对，则返回false
    if (startNum > endNum) return res;
    // 开始扫描，若可以访问，则添加到list中
    List<Future> futureList  = [];
    for (int i = startNum; i <= endNum; i++) {
      String currIp = IpUtils.num2ip(i);
      // 阻塞等待，直到成功抢占
      await TaskManager.waitUntilAvailable();
      // 开始扫描
      futureList.add(_isIpAccessible(currIp)
          .then((value){
            res.add(value);
            TaskManager.completeTask();
      }));
    }
    // 等待所有扫描完成
    await Future.wait(futureList)
        .timeout(Duration(milliseconds: ConfigValues.scanTimeout))
        .catchError((e){return res;});
    if (kDebugMode) {
      print("scan range completed...");
    }
    return res;
  }

  static Future<PingResult> scanIp(String ip) async {
    return _isIpAccessible(ip);
  }

  // 扫描指定IP地址
  static Future<PingResult> _isIpAccessible(String ip, {count = 2}) async {
    late PingResult res;
    switch (Platform.operatingSystem) {
      case Platforms.WINDOWS:
        res = await NetworkUtils.isAddressAccessibleByCmd(ip, count: count);
        break;
      default:
        res = await NetworkUtils.isAddressAccessible(ip, count: count);
    }
    if (kDebugMode) {
      if (res.isAccessible) {
        print(res);
      }
    }
    return res;
  }
}
