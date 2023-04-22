import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/l10n/l10n_str.dart';
import 'package:area_network_device_scanner/startup.dart';
import 'package:area_network_device_scanner/ui/pages/protocol/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // 初始化
    Future.delayed(Duration.zero,()=> startup());

    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: L10nTrans(),
      fallbackLocale: Status.EN_US,
      title: 'Device Detector',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // user and privacy protocol
    Future.delayed(Duration.zero,()=> ProtocolLogic.showProtocolPage(context));

    return const ScannerPage();
  }
}
