import 'dart:async';
import 'dart:io';

import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/task_manager.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/foundation.dart';

class PingApi {
  
  static final TaskManager _manager = TaskManager();

  // 过滤不可达结果
  static Stream<PingResult> getAccessibleIpWithRange(String start, String end) {
    StreamController<PingResult> sc = StreamController();
    sc.onPause = ()=>sc.close();
    _scanIpWithRangeByStream(start, end, sc);
    return sc.stream.where((event) => event.isAccessible);
  }

  static Stream<PingResult> scanIpWithRange(String start, String end) {
    StreamController<PingResult> sc = StreamController();
    _scanIpWithRangeByStream(start, end, sc);
    return sc.stream;
  }

  static Future<PingResult> scanIp(String ip) async {
    return _isIpAccessible(ip);
  }

  // 扫描一个ip区间
  static void _scanIpWithRangeByStream(
      String start, String end, StreamController<PingResult> sc) async {
    // 将起止ip转为数字
    int startNum = IpUtils.ip2num(start);
    int endNum = IpUtils.ip2num(end);
    // 若起止区间不对，则返回false
    if (startNum > endNum) return;
    // 开始扫描，若可以访问，则添加到list中
    List<Future> futureList = [];
    for (int i = startNum; i <= endNum; i++) {
      // 根据stream状态决定是否继续扫描
      if(sc.isClosed)break;
      // 获取当前ip地址
      String currIp = IpUtils.num2ip(i);
      // 阻塞等待，直到成功抢占
      await _manager.waitUntilAvailable(max: ConfigValues.CONFIG.maxBackGroundTaskCnt);
      // 开始扫描
      futureList.add(_isIpAccessible(currIp).then((value) {
        sc.sink.add(value);
        _manager.completeTask();
      }).onError((error, stackTrace) {
        _manager.completeTask();
      }));
    }
    // 等待所有扫描完成
    await Future.wait(futureList)
        .catchError((e) => Future.value([]));
    // 关闭stream
    sc.close();
    if (kDebugMode) {
      print("scan range $start to $end completed...");
    }
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
      // print(res);
    }
    return res;
  }
}
