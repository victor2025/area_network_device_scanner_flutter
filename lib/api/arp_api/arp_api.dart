
import 'dart:io';

import 'package:area_network_device_scanner/config/strings.dart';
import 'package:flutter/foundation.dart';

import 'src/win.dart';

abstract class ArpGetter{

  static final ArpGetter _getter = _initGetter();

  // 初始化getter
  static ArpGetter _initGetter(){
    late ArpGetter getter;
    switch (Platform.operatingSystem){
      case Platforms.WINDOWS:
        getter = WinArpGetter();
        break;
      case Platforms.ANDROID:
      //TODO
        break;
      case Platforms.LINUX:
      //TODO
        break;
      default:
        break;
    }
    if (kDebugMode) {
      print("arp loader has been initialized");
    }
    return getter;
  }

  // 从本地读取arp缓存
  static Future<Map<String,String>> loadArpCache() async{
    return await _getter.loadArpAsMap();
  }

  // 以字符串形式读取arp缓存
  Future<String> loadArpAsString();

  // 将字符串解析为map
  Future<Map<String,String>> loadArpAsMap();


}