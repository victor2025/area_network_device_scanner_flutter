import 'package:area_network_device_scanner/api/ping_api/ping_api.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/scan_tasks_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_list.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:get/get.dart';

final logic = Get.find<ScannerLogic>();
final state = logic.state;

Future<List<PingResult>> startScanTask(ScanTasks tasks) async{
  // // parse
  // ScanTasks tasks = ScanTasks.parseInput(input);
  // ping
  return _executeScanTask(tasks);
}

// 执行扫描任务
Future<List<PingResult>> _executeScanTask(ScanTasks tasks) async{
  // 读取arp表
  state.refreshArpCache();
  // 开始扫描
  List<PingResult> results = [];
  List<Future> futures = [];
  while(tasks.hasNextTask()){
    ScanTaskItem? task = tasks.getNextTask();
    if(task==null)break;
    futures.add(
        PingApi.scanIpWithRange(task.start,task.end)
            .then((value)=>results.addAll(value))
    );
  }
  // 等待所有任务完成
  await Future.wait(futures)
      .timeout(Duration(milliseconds: ConfigValues.scanTimeout))
      .catchError((e){return results;});
  return results;
}

// 开始扫描操作
ScanTasks beforeScan(String input){
  // 判断输入是否为空
  if(input.isEmpty)input = state.getLocalIp();
  ScanTasks tasks = ScanTasks.parseInput(input);
  // 若任务为空，则报错
  if(!tasks.hasNextTask())throw Exception("Invalid input!");
  // 更改状态
  state.setStatus("Scanning for: $tasks");
  state.scanning();
  // loading
  state.deviceListView = ConstWidgets.LOADING;
  return tasks;
}

void afterScan(List<PingResult> results){
  // 构建结果
  state.deviceListView = getDeviceListView(results);
  state.deviceNum = state.deviceList.length;
  state.notScanning();
  logic.update();
}