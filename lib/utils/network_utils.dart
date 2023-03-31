import 'dart:io';
import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/utils/codec_utils.dart';
import 'package:area_network_device_scanner/utils/platform_utils/win_utils.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';

class NetworkUtils {
  // 判断目标地址是否可达
  static Future<PingResult> isAddressAccessible(String addr, {count = 4}) async {
    // ios预先注册
    if (Platform.isIOS) {
      DartPingIOS.register();
    }
    // 开始执行
    final Ping ping = Ping(addr, count: count, encoding: CodecUtils.getCodec());
    List<PingData> dataList = await ping.stream.toList().catchError(()=>{[]});
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
        // TODO
        res = PingResult.failPing(addr);
        break;
    }
    return res;
  }

  // 将ip地址转换为数值形式
  static int ip2num(String ip) {
    List<int>? ipNumArr = parseIp(ip);
    // 需要保证ip是合法的
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

}
