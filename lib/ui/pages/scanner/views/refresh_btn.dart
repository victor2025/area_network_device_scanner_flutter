import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final logic = Get.find<ScannerLogic>();

class RefreshBtn extends StatelessWidget {
  const RefreshBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => logic.reScan(),
      child: const Icon(Icons.refresh),
    );
  }
}

class ScanningRefreshBtn extends StatelessWidget {
  const ScanningRefreshBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){},
      child: const Icon(Icons.access_time_outlined),
    );
  }
}

