import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ConfigValues{
  // 最大后台任务数目
  static int maxBackGroundTaskCnt = 64;
  // 是否显示公司名称
  static bool showDeviceCompany = false;
  // 是否显示公司全称
  static bool showFullCompanyName = true;
  // 是否显示任务信息
  static bool showTaskInfo = true;
  // 扫描超时时间
  static int scanTimeout = 40000;
  // 最大扫描ip数目
  static int maxIpRange = 255*2;
  // 任务切片大小
  static int taskSliceSize = IpUtils.ip2num("255.255.255.255")+1;
  // 是否已经显示用户协议
  static bool? isProtocolShown;

  static loadConfig() async{
    isProtocolShown = await SPUtil.getBool(PreferenceKeys.PROTOCOL)??false;
  }
}

class StyleConfigs{
  static MarkdownConfig markdownConfig = MarkdownConfig(
    configs: [
      const H1Config(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
      ),
      const H2Config(
        style: TextStyle(
          fontSize: 12
        )
      ),
      const PConfig(
        textStyle: TextStyle(fontSize: 10)
      )
    ]
  );
}