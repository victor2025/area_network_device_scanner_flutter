import 'dart:io';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/utils/codec_utils.dart';
import 'package:area_network_device_scanner/utils/platform_utils/win_utils.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';

class NetworkUtils {

  // 本地网络的可能名称
  static const Set<String> NETWORK_NAMES = {"以太网","WLAN","Ethernet","eth0","wlan0"};
  static const Duration PING_TIMEOUT = Duration(milliseconds: 10000);

  // 判断目标地址是否可达
  static Future<PingResult> isAddressAccessible(String addr, {count = 4}) async {
    // ios预先注册
    if (Platform.isIOS) {
      DartPingIOS.register();
    }
    // 开始执行
    final Ping ping = Ping(addr, count: count, encoding: CodecUtils.getCodec());
    List<PingData> dataList = await ping.stream.toList()
        .timeout(PING_TIMEOUT)
        .catchError((e)=>Future.value(<PingData>[]));
    return PingResult.parsePingDataList(addr, dataList);
  }

  // 通过命令行判断目标地址是否可达
  static Future<PingResult> isAddressAccessibleByCmd(String addr, {count = 4}) async{
    late PingResult res;
    late String pingRes;
    switch(Platform.operatingSystem){
      case Platforms.WINDOWS:
        pingRes = await WinUtils.runPingCommand(addr)
            .timeout(PING_TIMEOUT)
            .catchError((e)=>Future.value(''));
        res = WinUtils.parsePingRes(addr, pingRes);
        break;
      default:
        res = PingResult.failPing(addr);
        break;
    }
    return res;
  }

  static Future<Set<String>> getIpsFromNetworkInterface() async{
    Set<String> ipSet = {};
    // 获取所有网络接口
    List<NetworkInterface> interfaceList = await NetworkInterface
        .list(type: InternetAddressType.IPv4);
    // 从网络接口中获取ip地址
    for (var value in interfaceList) {
      if(NETWORK_NAMES.contains(value.name)){
        ipSet.add(value.addresses[0].address);
      }
    }
    return ipSet;
  }

}
