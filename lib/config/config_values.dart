import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConfigValues{

  static const int MIN_THREAD_NUMBER = 16;
  static const int MAX_THREAD_NUMBER = 1024;
  static const int MIN_TIMEOUT = 15000;
  static const int MAX_TIMEOUT = 120000;

  static ConfigValues CONFIG = ConfigValues();

  // protocol
  bool? isProtocolShown;
  // 是否显示公司名称
  late bool showDeviceCompany;
  // 是否显示公司全称
  late bool showFullCompanyName;
  // 最大后台任务数目
  late int maxBackGroundTaskCnt;
  // 开启扫描超时
  late bool enableTimeout;
  // 扫描超时时间
  late int scanTimeout;
  // 任务切片大小
  late int taskSliceSize;
  // 语言
  late bool isChinese;

  ConfigValues();

  static initConfigs() async{
    initProtocolStatus();
    initLanguage();
    SPUtil.getBool(PreferenceKeys.COMPANY_KEY).then((value) => CONFIG.showDeviceCompany = value??false);
    CONFIG.showFullCompanyName = false;
    SPUtil.getInt(PreferenceKeys.TASK_CNT_KEY).then((value) => CONFIG.maxBackGroundTaskCnt = value??128);
    SPUtil.getBool(PreferenceKeys.ENABLE_TIMEOUT_KEY).then((value) => CONFIG.enableTimeout = value??true);
    SPUtil.getInt(PreferenceKeys.SCAN_TIMEOUT_KEY).then((value) => CONFIG.scanTimeout = value??30000);
    CONFIG.taskSliceSize = IpUtils.ip2num("255.255.255.255")+1;
  }

  static initProtocolStatus() async{
    CONFIG.isProtocolShown = await SPUtil.getBool(PreferenceKeys.PROTOCOL)??false;
  }

  static initLanguage() async{
    CONFIG.isChinese = await SPUtil.getBool(PreferenceKeys.LANGUAGE_KEY)??true;
    CONFIG.updateLanguage();
  }

  saveProtocolStatus(bool status){
    isProtocolShown = status;
    SPUtil.save(PreferenceKeys.PROTOCOL, isProtocolShown);
  }

  saveShowCompany(bool showCompany){
    showDeviceCompany = showCompany;
    SPUtil.save(PreferenceKeys.COMPANY_KEY, showDeviceCompany);
  }

  saveThreadNumber(int threadNumber){
    maxBackGroundTaskCnt = threadNumber;
    SPUtil.save(PreferenceKeys.TASK_CNT_KEY, maxBackGroundTaskCnt);
  }

  saveTimeout(bool enable, int timeout){
    enableTimeout = enable;
    SPUtil.save(PreferenceKeys.ENABLE_TIMEOUT_KEY, enableTimeout);
    if(enableTimeout){
      scanTimeout = timeout;
      SPUtil.save(PreferenceKeys.SCAN_TIMEOUT_KEY, scanTimeout);
    }
  }

  saveLanguage(bool lang){
    isChinese = lang;
    SPUtil.save(PreferenceKeys.LANGUAGE_KEY, isChinese);
    updateLanguage();
  }

  updateLanguage(){
    Locale newLocale = isChinese?Status.ZH_CN:Status.EN_US;
    if(newLocale.languageCode!=Get.locale?.languageCode) Get.updateLocale(newLocale);
  }

}