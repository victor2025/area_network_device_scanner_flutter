import 'package:area_network_device_scanner/api/ping_api/ping_api.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/entity/config_entity.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/scan_tasks_entity.dart';
import 'package:area_network_device_scanner/entity/task_manager.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/state.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/device_list.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';

class ScanLogic {
  final ScannerState state;

  ScanLogic(this.state);

  // 执行扫描任务
  Future<List<PingResult>> startScanTask(ScanTasks tasks) async {
    // 读取arp表
    state.refreshArpCache();
    // 开始扫描
    List<PingResult> results = [];
    List<Future> futures = [];
    while (tasks.hasNextTask()) {
      ScanTaskItem? task = tasks.getNextTask();
      if (task == null) break;
      // 限制任务数目
      TaskManager.waitUntilAvailable();
      futures.add(PingApi.scanIpWithRange(task.start, task.end).then((value) {
        results.addAll(value);
        TaskManager.completeTask();
      }));
    }
    // 等待所有任务完成
    await Future.wait(futures)
        .timeout(Duration(milliseconds: ConfigValues.scanTimeout))
        .catchError((e) {
      return results;
    });
    return results;
  }

  // 开始扫描操作
  ScanTasks beforeScan(String input) {
    // 判断输入是否为空
    if (input.isEmpty) input = state.getLocalIpsAsString();
    ScanTasks tasks = ScanTasks.parseInput(input);
    // 若任务为空，则报错
    if (!tasks.hasNextTask()) throw Exception("Invalid input!");
    // 更改状态
    _setScanStatus(tasks);
    state.scanning();
    // loading
    state.deviceListView = ConstWidgets.LOADING;
    return tasks;
  }

  void afterScan(List<PingResult> results) {
    // 根据ip地址排序
    results.sort((a, b) {
      return IpUtils.ipCompare(a.ip, b.ip);
    });
    // 构建结果
    state.deviceListView = DeviceListView(data: results);
    state.deviceNum = state.deviceList.length;
    state.setStatus("Scan completed");
    state.notScanning();
  }

  void _setScanStatus(ScanTasks tasks) {
    late String status;
    if (ConfigEntity.CONFIG.showTaskInfo) {
      status = "Scanning ${tasks.getScanCount()} ips | Tasks: $tasks";
    } else {
      status = "Scanning ${tasks.getScanCount()} ips";
    }
    state.setStatus(status);
  }
}
