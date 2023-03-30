import 'dart:convert';
import 'dart:io';
import 'package:fast_gbk/fast_gbk.dart';

class CodecUtils{

  static Encoding? _codec;

  static Encoding getCodec(){
    CodecUtils._codec ??= Platform.isWindows?gbk:utf8;
    return CodecUtils._codec!;
  }
}