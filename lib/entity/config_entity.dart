import 'package:area_network_device_scanner/config/values.dart';

class ConfigEntity{

  static ConfigEntity CONFIG = ConfigEntity();

  // 最大后台任务数目
  late int maxBackGroundTaskCnt;
  // 是否显示公司名称
  late bool showDeviceCompany;
  // 是否显示公司全称
  late bool showFullCompanyName;
  // 是否显示任务信息
  late bool showTaskInfo;
  // 扫描超时时间
  late int scanTimeout;
  // 最大扫描ip数目
  late int maxIpRange;
  // 任务切片大小
  late int taskSliceSize;

  ConfigEntity(){
    maxBackGroundTaskCnt = ConfigValues.maxBackGroundTaskCnt;
    showDeviceCompany = ConfigValues.showDeviceCompany;
    showFullCompanyName = ConfigValues.showFullCompanyName;
    showTaskInfo = ConfigValues.showTaskInfo;
    scanTimeout = ConfigValues.scanTimeout;
    maxIpRange = ConfigValues.maxIpRange;
    taskSliceSize = ConfigValues.taskSliceSize;
  }


}