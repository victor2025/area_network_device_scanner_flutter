import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/entity/mac_entity.dart';
import 'package:area_network_device_scanner/entity/task_manager.dart';
import 'package:area_network_device_scanner/utils/http_utils.dart';
import 'package:area_network_device_scanner/utils/rand_utils.dart';
import 'package:area_network_device_scanner/utils/string_utils.dart';
import 'package:http/http.dart' as http;

class MacApi{

  static final TaskManager _manager = TaskManager();

  static const String _MAC_QUERY_URL = "https://api.macvendors.com/";

  static Future<MacResult> getMacResultByIp(String ip) async{
    MacResult data = await _getMacFromArp(ip);
    // 若关闭公司查询功能，则不再查询
    return data;
  }

  static Future<MacResult> getMacResultWithCompany(MacResult data){
    return _getDeviceNameByMac(data);
  }

  // 从arp列表中获取mac地址
  static Future<MacResult> _getMacFromArp(String ip) async{
    final Map<String,String> arp = await ArpApi.loadArpCache();
    String? mac = arp[ip];
    return mac==null?MacResult.unknownResult(ip):MacResult.withoutNameResult(ip, mac.toUpperCase());
  }

  static Future<MacResult> _getDeviceNameByMac(MacResult data) async{
    if(!data.hasMac())return data;
    // 生成url
    String url = _getMacQueryUrl(data);
    // 发起请求
    await _manager.waitUntilAvailable(max: 3);
    String? respBody = await _queryUrlForName(url)
        .timeout(const Duration(milliseconds: 60000))
        .catchError((e){
          _manager.completeTask();
          return "errors";
        })
        .then((value){
          _manager.completeTask();
          return Future.value(value);
        });
    // 解析respBody
    _parseRespBody(data,respBody);
    return data;
  }

  static Future<String?> _queryUrlForName(String url) async{
    http.Response resp = await HttpUtils.requestGet(url);
    if(resp.statusCode==HttpUtils.STATUS_OK){
      return resp.body;
    }else if(resp.statusCode == HttpUtils.STATUS_TOO_MANY_REQUESTS){
      // 等待一段时间后重新发送请求
      await Future.delayed(Duration(milliseconds: RandUtils.randRange(400, 2000)));
      return await _queryUrlForName(url)
      .then((value){
        return value;
      }).catchError((e){
        return Future.value("errors");
      });
    }
    return "errors";
  }

  static String _getMacQueryUrl(MacResult data){
    String mac = data.mac.replaceAll(":", "");
    return "$_MAC_QUERY_URL$mac";
  }

  // 从返回体中解析设备名称
  static void _parseRespBody(MacResult data, String? resp){
    if(resp!=null&&!resp.contains("errors")) {
      data.name = StringUtils.parseCompanyName(resp);
    }
  }

}