import 'package:get/get.dart';

class L10nTrans extends Translations{

  @override
  Map<String, Map<String, String>> get keys {
    return {"en_us": _enUs, "zh_cn": _zhCn};
  }

  final Map<String,String> _enUs = {
    "language": "English",
    // front page
    "localIp": "Local Ip",
    "wifiName": "WiFi Name",
    "deviceNumber": "Device Number",
    // device card
    "ipAddress": "Ip Address",
    "delay": "Delay",
    "mac": "Mac",
    "company": "Company",
    // input page
    "startScan": "Start Scan",
    "inputTips": "Input ip or ip range you want, and split with commas.\nFor example: \"172.30.1.1, 192.168.1.1-192.168.1.255\".\nCurrent default:",
    // info page
    "appInfo": "App Information",
    "appIntro": "Introduction",
    "usageProtocol": "Usage Protocol",
    "privacyProtocol": "Privacy Protocol",
    // setting page
    "appSetting": "Settings",
    "showCompanySetting": "Show company",
    "threadNumberSetting": "Max thread number",
    "enableTimeoutSetting": "Enable scan timeout",
    "scanTimeoutSetting": "Scan timeout (second)",
    "languageSetting": "Language",
    "disabled": "disabled",
    // status
    "tapStatus": "Tap to scan",
    "scanStatusPrefix": "Scan ",
    "scanStatusSuffix": " Ips",
    "scanTaskPrefix": "Tasks",
    "allClearedStatus": "All cleared",
    // errors
    "invalidInput": "Invalid input!",
    // protocol
    "userProtocolTitle": "User Protocol",
    "usageProtocolTitle": "\"Usage Protocol\"",
    "privacyProtocolTitle": "\"Privacy Protocol\"",
    "userProtocolPrefix": "We respect and protect legal rights of users from any defence. Please carefully read our ",
    "userProtocolSuffix": " before use our products and services. If you agree, click \"agree\" to start using our products and services.",
    "and": " and ",
    // btn
    "agree": "Agree",
    "exit": "Exit",
    "back": "Back",
    "cancel": "Cancel",
    "save": "Save",
  };

  final Map<String,String> _zhCn = {
    "language": "中文",
    "localIp": "本地Ip",
    "wifiName": "WiFi名称",
    "deviceNumber": "设备数目",
    "ipAddress": "Ip地址",
    "delay": "延迟",
    "mac": "Mac地址",
    "company": "生产厂家",
    "startScan": "开始扫描",
    "inputTips": "输入你想扫描的ip或ip范围，并采用逗号分割，\n例如：\"172.30.1.1, 192.168.1.1-192.168.1.255\"。\n当前默认：",
    "appInfo": "应用信息",
    "appIntro": "应用说明",
    "usageProtocol": "使用条款",
    "privacyProtocol": "隐私协议",
    "appSetting": "设置",
    "showCompanySetting": "显示厂商",
    "threadNumberSetting": "最大扫描线程数",
    "enableTimeoutSetting": "启用扫描超时时间",
    "scanTimeoutSetting": "扫描超时时间(秒)",
    "languageSetting": "语言",
    "disabled": "无效",
    "tapStatus": "点击以扫描",
    "scanStatusPrefix": "共扫描",
    "scanStatusSuffix": "个Ip地址",
    "scanTaskPrefix": "任务",
    "allClearedStatus": "已全部清除",
    "invalidInput": "无效输入!",
    "userProtocolTitle": "用户协议",
    "usageProtocolTitle": "《使用条款》",
    "privacyProtocolTitle": "《隐私协议》",
    "userProtocolPrefix": "我们尊重并保护用户的合法权益不受到任何侵犯，请在使用我们产品和服务前务必认真阅读我们的",
    "userProtocolSuffix": "的内容，如果您同意，请点击\"同意\"开始使用我们的产品和服务。",
    "and": "和",
    "agree": "同意",
    "exit": "退出",
    "back": "返回",
    "cancel": "取消",
    "save": "保存",
  };

}