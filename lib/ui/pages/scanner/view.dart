import 'package:area_network_device_scanner/ui/pages/scanner/views/local_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ScannerLogic());

    return Scaffold(
      appBar: AppBar(
        title: const ScannerAppBarTitle(),
      ),
      body: const ScannerBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.startScan(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class ScannerAppBarTitle extends StatelessWidget {
  const ScannerAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    final state = Get.find<ScannerLogic>().state;
    final logic = Get.put(ScannerLogic());
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.black12),
          child: Row(
            children: [
              IconButton(
                onPressed: () => logic.clearDeviceList(),
                icon: const Icon(Icons.clear_rounded),
                splashColor: Colors.black12,
              ),
            ],
          ),
        ),
        const Divider(
          height: 2,
        ),
        Expanded(
            child: GetBuilder<ScannerLogic>(
                builder: (context) => ListView(
                      children: state.deviceList,
                    ))),
      ],
    );
  }
}
