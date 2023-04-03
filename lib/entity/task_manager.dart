import 'package:area_network_device_scanner/config/values.dart';

class TaskManager{
  // 当前后台任务数目
  static int _currBackGroundTaskCnt = 0;

  // 用来限制后台任务的数目
  static bool isAvailable(){
    return _currBackGroundTaskCnt<ConfigValues.maxBackGroundTaskCnt;
  }

  // 阻塞等待，直到有空闲
  static waitUntilAvailable() async{
    while(!isAvailable()){
      await Future.delayed(const Duration(milliseconds: 10));
    }
    addTaskCnt();
  }

  static void addTaskCnt(){
    _currBackGroundTaskCnt++;
    print(_currBackGroundTaskCnt);
  }

  static void subTaskCnt(){
    _currBackGroundTaskCnt--;
  }

}