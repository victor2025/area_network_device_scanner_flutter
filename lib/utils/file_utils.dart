import 'dart:io';

import 'package:area_network_device_scanner/utils/codec_utils.dart';

class FileLoader{

  static Future<String> loadFileAsString(String filepath) async{
    var file = File(filepath);
    String content = await file.readAsString(encoding: CodecUtils.getCodec())
        .catchError((error, stackTrace) => "");
    return content;
  }

}
