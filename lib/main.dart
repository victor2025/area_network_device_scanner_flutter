import 'package:area_network_device_scanner/startup.dart';
import 'package:area_network_device_scanner/ui/pages/protocol/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/view.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // 初始化
    Future.delayed(Duration.zero,()=> startup());
    
    return MaterialApp(
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
