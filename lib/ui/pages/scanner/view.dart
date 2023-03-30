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
        title: Text("test scanner"),
      ),
      body: ScannerBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.startScan(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class ScannerBody extends StatelessWidget {
  const ScannerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get
        .find<ScannerLogic>()
        .state;
    final logic = Get.put(ScannerLogic());
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () => logic.clearDeviceList(),
                icon: Icon(Icons.clear)
            ),
            Obx((){
              return Text("device number: ${state.deviceNum.value}");
            })
          ],
        ),

        Expanded(
            child: GetBuilder<ScannerLogic>(
                builder: (context) => state.deviceListWidget
            )
        )
      ],
    );
  }
}

