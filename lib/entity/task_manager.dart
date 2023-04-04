import 'package:area_network_device_scanner/entity/config_entity.dart';

class TaskManager{
  // 当前后台任务数目
  static int _currBackGroundTaskCnt = 0;

  // 用来限制后台任务的数目
  static bool _isAvailable(int maxCnt){
    return _currBackGroundTaskCnt<maxCnt;
  }

  // 阻塞等待，直到有空闲
  static waitUntilAvailable({int? max}) async{
    final int maxCnt = max??ConfigEntity.CONFIG.maxBackGroundTaskCnt;
    while(!_isAvailable(maxCnt)){
      await Future.delayed(const Duration(milliseconds: 10));
    }
    _addTaskCnt();
  }

  static void _addTaskCnt(){
    _currBackGroundTaskCnt++;
  }

  static void completeTask(){
    _currBackGroundTaskCnt--;
  }

}