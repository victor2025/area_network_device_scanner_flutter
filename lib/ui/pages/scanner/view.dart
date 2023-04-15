import 'package:area_network_device_scanner/ui/pages/scanner/views/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ScannerLogic());
    final state = logic.state;

    // 刷新列表
    logic.refreshState();

    // 用戶协议
    Future.delayed(Duration.zero, ()=>logic.showAlertDialog(context));

    return Scaffold(
        appBar: AppBar(
          title: const ScannerAppBarTitle(),
        ),
        body: const ScannerBody(),
        floatingActionButton:
            GetBuilder<ScannerLogic>(builder: (context) => state.refreshBtn));
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
          child: Text(
            "Device Detector",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
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
        const StatusBar(),
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
