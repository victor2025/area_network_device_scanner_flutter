import 'dart:convert';
import 'dart:io';

import 'package:area_network_device_scanner/utils/codec_utils.dart';
import 'package:flutter/services.dart';

class FileLoader{

  static Future<String> loadFileAsString(String filepath) async{
    var file = File(filepath);
    String content = await file.readAsString(encoding: CodecUtils.getCodec())
        .catchError((error, stackTrace){
          return file.readAsStringSync(encoding: utf8);
    });
    return content;
  }

  static Future<String> loadAssetsAsString(String path){
    return rootBundle.loadString(path)
        .catchError((e){
          return Future.value(e.toString());
    });
  }
}
