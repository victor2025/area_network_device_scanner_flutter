import 'package:area_network_device_scanner/config/config_values.dart';

class SettingState {

  final ConfigValues config = ConfigValues.CONFIG;
  late bool showCompany;
  late int threadNumber;
  late bool enableTimeout;
  late int scanTimeout; // second
  late bool isChinese;

  SettingState(){
    loadConfigs();
  }

  void loadConfigs(){
    showCompany = config.showDeviceCompany;
    threadNumber = config.maxBackGroundTaskCnt;
    enableTimeout = config.enableTimeout;
    scanTimeout = config.scanTimeout~/1000;
    isChinese = config.isChinese;
  }

  void switchShowCompany()=>showCompany = !showCompany;
  void switchLanguage()=>isChinese = !isChinese;

  void threadNumberCountDown(){
    if(threadNumber>ConfigValues.MIN_THREAD_NUMBER) {
      threadNumber-=16;
    }
  }

  void threadNumberCountUp(){
    if(threadNumber<ConfigValues.MAX_THREAD_NUMBER) {
      threadNumber+=16;
    }
  }

  void switchEnableTimeout()=>enableTimeout = !enableTimeout;
  void timeoutCountDown(){
    if(enableTimeout&&scanTimeout*1000>ConfigValues.MIN_TIMEOUT) {
      scanTimeout-=5;
    }
  }

  void timeoutCountUp(){
    if(enableTimeout&&scanTimeout*1000<ConfigValues.MAX_TIMEOUT) {
      scanTimeout+=5;
    }
  }

  // 保存设置
  void saveConfigs(){
    config.saveShowCompany(showCompany);
    config.saveThreadNumber(threadNumber);
    config.saveTimeout(enableTimeout, scanTimeout*1000);
    config.saveLanguage(isChinese);
  }
  
}
