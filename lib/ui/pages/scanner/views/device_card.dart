import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

// 获取设备卡片
Widget getDeviceCard(PingResult res) {
  return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      elevation: 20,
      margin: const EdgeInsets.all(3),
      child: Column(children: [
        ListTile(
          title: const Text("Ip Address:", style: TextStyle(fontSize: 12)),
          subtitle: Text(res.ip,
              style: const TextStyle(fontSize: 20, color: Colors.black)),
        ),
        const Divider(),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: ListTile(
                title: Text("Device Name:", style: TextStyle(fontSize: 12)),
                subtitle: Text("unknown",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 1,
              child: ListTile(
                title: const Text("Delay:", style: TextStyle(fontSize: 12)),
                subtitle: Text("${res.rtt}ms",
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
          ],
        )
      ])
  );
}