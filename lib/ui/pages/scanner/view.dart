import 'package:area_network_device_scanner/ui/pages/scanner/views/input_bar.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/local_info.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ScannerLogic());
    final state = logic.state;
    // 刷新列表
    logic.refreshDeviceList();

    return Scaffold(
        appBar: AppBar(
          title: const ScannerAppBarTitle(),
        ),
        body: const ScannerBody(),
        floatingActionButton: GetBuilder<ScannerLogic>(builder: (logic) {
          return FloatingActionButton(
            onPressed: state.isScanning ? () => {} : () => logic.startScan(),
            child: const Icon(Icons.refresh),
          );
        }));
  }
}

class ScannerAppBarTitle extends StatelessWidget {
  const ScannerAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<ScannerLogic>().state;
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: Text("test scanner"),
        ),
        Expanded(
          flex: 3,
          child:
              GetBuilder<ScannerLogic>(builder: (context) => state.localInfo),
        )
      ],
    );
  }
}

class ScannerBody extends StatelessWidget {
  const ScannerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ScannerLogic>();
    final state = logic.state;
    return Column(
      children: [
        getStatusBar(context),
        const Divider(
          height: 2,
        ),
        Expanded(
            child: GetBuilder<ScannerLogic>(
                builder: (context) => state.deviceListView)),
      ],
    );
  }
}
