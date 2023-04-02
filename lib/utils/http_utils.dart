import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpUtils {
  static const STATUS_OK = 200;
  static const STATUS_TOO_MANY_REQUESTS = 429;
  static const HTTP_PREFIX = "http://";
  static const HTTPS_PREFIX = "https://";
  static const HTTP_HEADER = {
    "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
  };

  static Future<http.Response> requestGet(String url) async{
    // 处理url
    url = parseProtocol(url);
    // 发起请求
    http.Response resp = await http
        .get(Uri.parse(url),headers: HTTP_HEADER)
        .timeout(const Duration(milliseconds: 30000))
        .catchError(httpOnError);
    // 处理响应
    if (kDebugMode) {
      print("from $url get http response: ${resp.statusCode}: ${resp.body}");
    }
    return resp;
  }

  // 在得到响应后执行对应函数
  static Future<String?> getBodyWithUrl(String url) async {
    String? result;
    // 处理url
    url = parseProtocol(url);
    // 发起请求
    http.Response resp = await http
        .get(Uri.parse(url),headers: HTTP_HEADER)
        .timeout(const Duration(milliseconds: 30000))
        .catchError(httpOnError);
    // 处理响应
    if (kDebugMode) {
      print("from $url get http response: ${resp.statusCode}: ${resp.body}");
    }
    if (resp.statusCode == HttpUtils.STATUS_OK) {
      result = resp.body;
    }
    return result;
  }

  // 解析url，增加协议名
  static String parseProtocol(String url) {
    if (!url.startsWith(HttpUtils.HTTP_PREFIX) &&
        !url.startsWith(HttpUtils.HTTPS_PREFIX)) {
      url = HttpUtils.HTTP_PREFIX + url;
    }
    return url;
  }

  static http.Response httpOnError(e, s){
    if (kDebugMode) {
      print("$e\n$s");
    }
    return http.Response("errors",STATUS_OK);
  }
}
