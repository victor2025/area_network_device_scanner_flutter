import 'dart:async';

import 'package:area_network_device_scanner/api/ping_api/ping_api.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/entity/scan_tasks_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/state.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:area_network_device_scanner/utils/thread_utils.dart';
import 'package:get/get.dart';

class ScanLogic {
  final ScannerState state;
  final List<StreamSubscription<PingResult>> subList = [];

  ScanLogic(this.state);

  beforeScan(String input) {
    // 判断输入是否为空
    if (input.isEmpty) input = state.getLocalIpsAsString();
    ScanTasks tasks = ScanTasks.parseInput(input);
    // 若任务为空，则报错
    if (!tasks.hasNextTask()) throw Exception('invalidInput'.tr);
    // 更改状态
    _setScanStatus(tasks);
  }

  doScan() {
    StreamController<PingResult> sc = StreamController();
    // start scan
    _startScanTask(sc);
    state.scanStream = sc.stream;
    state.deviceListView = ConstWidgets.EMPTY_TEXT;
  }

  afterScan() {
    state.notScanning();
  }

  void stopScan() {
    _pauseAllStreams();
    afterScan();
  }

  void _pauseAllStreams() {
    state.scanSub?.pause();
    for (var ele in subList) {
      ele.pause();
    }
  }

  void _setScanStatus(ScanTasks tasks) {
    late String status;
    status =
        "${'scanStatusPrefix'.tr}${tasks.getScanCount()}${'scanStatusSuffix'.tr} | ${'scanTaskPrefix'.tr}: $tasks";
    state.setStatus(status);
    state.scanning();
    // cache tasks
    state.tasks = tasks;
  }

  // 执行扫描任务
  void _startScanTask(StreamController<PingResult> sc) async{
    final ScanTasks tasks = state.tasks;
    // 等待ui响应
    await ThreadUtils.sleep(100);
    // 读取arp表
    state.refreshArpCache();
    // 开始扫描
    int taskCnt = tasks.getTaskCount();
    while (tasks.hasNextTask()) {
      ScanTaskItem? task = tasks.getNextTask();
      if (task == null) break;
      StreamSubscription<PingResult> ss =
          PingApi.getAccessibleIpWithRange(task.start, task.end).listen(
        (event) {
          sc.sink.add(event);
        },
        onDone: () {
          // 扫描完成后关闭流
          if (--taskCnt == 0) sc.close();
        },
      );
      subList.add(ss);
    }
  }
}
