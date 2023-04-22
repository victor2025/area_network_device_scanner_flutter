import 'package:area_network_device_scanner/config/values.dart';

class SettingState {

  bool showCompany = false;
  int threadNumber = 128;
  bool enableTimeout = true;
  int scanTimeout = 30;
  bool isChinese = true;

  SettingState();

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
  
}
