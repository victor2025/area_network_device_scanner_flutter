import 'package:area_network_device_scanner/api/ping_api/ping_api.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/scan_task.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_list.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:get/get.dart';

final logic = Get.find<ScannerLogic>();
final state = logic.state;

Future<List<PingResult>> parseInputAndScanIpWithRange(String input){
  // parse
  ScanTasks tasks = ScanTasks.parseInput(input);
  state.setStatus("Scanning: $tasks");
  // ping
  return _executeScanTask(tasks);
}

// 根据本地ip地址扫描局域网设备
Future<List<PingResult>> scanIpRangeWithLocalIp() async{
  String ip = state.getLocalIp();
  return _executeScanTask(ScanTasks.parseInput(ip));
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
  await Future.wait(futures);
  return results;
}

// 开始扫描操作
beforeScan(){
  // 更改状态
  state.deviceListView = ConstWidgets.LOADING;
  state.scanning();
}

afterScan(List<PingResult> results){
  // 构建结果
  state.deviceListView = getDeviceListView(results);
  state.deviceNum = state.deviceList.length;
  state.notScanning();
  logic.update();
}