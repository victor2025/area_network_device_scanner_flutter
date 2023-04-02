import 'dart:io';

import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/entity/mac_entity.dart';
import 'package:area_network_device_scanner/utils/http_utils.dart';
import 'package:http/http.dart' as http;

class MacApi{

  static const String _MAC_QUERY_URL = "https://api.macvendors.com/";

  static Future<MacResult> getMacResultByIp(String ip) async{
    MacResult data = await _getMacFromArp(ip);
    return _getDeviceNameByMac(data);
  }

  // 从arp列表中获取mac地址
  static Future<MacResult> _getMacFromArp(String ip) async{
    final Map<String,String> arp = await ArpApi.getArpCache();
    String? mac = arp[ip];
    return mac==null?MacResult.unknownResult(ip):MacResult.withoutNameResult(ip, mac.toUpperCase());
  }

  static Future<MacResult> _getDeviceNameByMac(MacResult data) async{
    if(!data.hasMac())return data;
    // 生成url
    String url = _getMacQueryUrl(data);
    // 发起请求
    String? respBody = await _queryUrlForName(url);
    // 解析respBody
    _parseRespBody(data,respBody);
    return data;
  }

  static Future<String?> _queryUrlForName(String url) async{
    http.Response resp = await HttpUtils.requestGet(url);
    if(resp.statusCode==HttpUtils.STATUS_OK){
      return resp.body;
    }else if(resp.statusCode == HttpUtils.STATUS_TOO_MANY_REQUESTS){
      return await _queryUrlForName(url);
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
      data.name = resp.split(" ")[0];
    }
  }

}