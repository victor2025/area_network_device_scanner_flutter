
import 'dart:io';

import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/utils/reg_exp_utils.dart';
import 'package:flutter/foundation.dart';

import 'src/android.dart';
import 'src/linux.dart';
import 'src/win.dart';

abstract class ArpApi{

  static final ArpApi _getter = _initGetter();
  static Map<String,String>? _arpCache;

  // 初始化getter
  static ArpApi _initGetter(){
    late ArpApi getter;
    switch (Platform.operatingSystem){
      case Platforms.WINDOWS:
        getter = WinArpGetter();
        break;
      case Platforms.ANDROID:
        getter = AndroidArpGetter();
        break;
      default:
        getter = LinuxArpGetter();
        break;
    }
    if (kDebugMode) {
      print("arp loader has been initialized");
    }
    return getter;
  }

  // 从本地读取arp缓存
  static Future<Map<String,String>> loadArpCache() async{
    _arpCache =  await _getter.loadArpAsMap();
    if (kDebugMode) {
      print("arp cache has been loaded");
    }
    return _arpCache!;
  }

  // 获取arp表格
  static Future<Map<String,String>> getArpCache() async{
    if(_arpCache==null){
      await loadArpCache();
    }
    return _arpCache!;
  }

  // 以字符串形式读取arp缓存
  Future<String> loadArpAsString();

  // 将字符串解析为map
  Future<Map<String,String>> loadArpAsMap();

  Map<String,String> parseArpCache(String str){
    Map<String,String> res = {};
    List<String> lines = str.split("\n");
    for (var line in lines) {
      if(line.isEmpty)continue;
      // 匹配ip
      String? ip = RegExpUtils.getIp(line);
      if(ip==null)continue;
      // 匹配mac
      String? mac = RegExpUtils.getMac(line);
      if(mac==null)continue;
      // 放入map
      res[ip] = mac;
    }
    return res;
  }

}