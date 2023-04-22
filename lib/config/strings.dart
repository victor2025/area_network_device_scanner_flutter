import 'package:flutter/cupertino.dart';

class Platforms{
  static const WINDOWS = 'windows';
  static const ANDROID = 'android';
  static const LINUX = 'linux';
}

class Status{
  static const String UNKNOWN = "unknown";
  static const String DEF_IP = "192.168.0.1";
  static const Locale ZH_CN = Locale("zh","cn");
  static const Locale EN_US = Locale("en","us");
}

class PreferenceKeys{
  static const String PROTOCOL = "isProtocolShown";
}

class Paths{
  static const String USAGE_PROTOCOL_PATH = "docs/usage-agreement.md";
  static const String PRIVACY_PROTOCOL_PATH = "docs/privacy-agreement.md";
  static const String INFO_PATH = "docs/app-info.md";
  static const String VERSION_PATH = "docs/version-str";
}