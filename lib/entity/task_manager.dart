import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/utils/thread_utils.dart';
import 'package:flutter/foundation.dart';

class TaskManager{
  // 当前后台任务数目
  int _currBackGroundTaskCnt = 0;

  // 用来限制后台任务的数目
  bool _isAvailable(int maxCnt){
    return _currBackGroundTaskCnt<maxCnt;
  }

  // 阻塞等待，直到有空闲
  waitUntilAvailable({int? max}) async{
    final int maxCnt = max??ConfigValues.CONFIG.maxBackGroundTaskCnt;
    while(!_isAvailable(maxCnt)){
      await ThreadUtils.sleep(10);
    }
    if (kDebugMode) {
      // print('$_currBackGroundTaskCnt/$maxCnt');
    }
    _addTaskCnt();
  }

  void _addTaskCnt(){
    _currBackGroundTaskCnt++;
  }

  void completeTask(){
    _currBackGroundTaskCnt--;
  }

  void refresh(){
    _currBackGroundTaskCnt = 0;
  }

}