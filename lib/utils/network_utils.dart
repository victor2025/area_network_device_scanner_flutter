import 'dart:io';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/mac_entity.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/utils/codec_utils.dart';
import 'package:area_network_device_scanner/utils/platform_utils/win_utils.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkUtils {
  // 判断目标地址是否可达
  static Future<PingResult> isAddressAccessible(String addr, {count = 4}) async {
    // ios预先注册
    if (Platform.isIOS) {
      DartPingIOS.register();
    }
    // 开始执行
    final Ping ping = Ping(addr, count: count, encoding: CodecUtils.getCodec());
    List<PingData> dataList = await ping.stream.toList()
        .catchError((e)=>{print(e),[]},)
        .timeout(const Duration(milliseconds: 30000));
    return PingResult.parsePingDataList(addr, dataList);
  }

  // 通过命令行判断目标地址是否可达
  static Future<PingResult> isAddressAccessibleByCmd(String addr, {count = 4}) async{
    late PingResult res;
    late String pingRes;
    switch(Platform.operatingSystem){
      case Platforms.WINDOWS:
        pingRes = await WinUtils.runPingCommand(addr);
        res = WinUtils.parsePingRes(addr, pingRes);
        break;
      default:
        res = PingResult.failPing(addr);
        break;
    }
    return res;
  }

}
