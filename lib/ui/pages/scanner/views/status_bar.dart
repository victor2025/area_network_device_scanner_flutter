import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/input_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

final logic = Get.find<ScannerLogic>();
final state = logic.state;


Row getStatusBar(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: ListTile(
          leading: SpeedDial(
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            icon: Icons.add,
            elevation: 4.0,
            buttonSize: const Size(44, 44),
            activeIcon: Icons.close,
            direction: SpeedDialDirection.right,
            spaceBetweenChildren: 4.0,
            spacing: 4.0,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.edit),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                onTap: () => SendCommentPage.show(context),
              ),
              SpeedDialChild(
                child: const Icon(Icons.clear_all),
                backgroundColor: Colors.orange[300],
                foregroundColor: Colors.white,
                onTap: () => logic.refreshDeviceList(),
              ),
              SpeedDialChild(
                child: const Icon(Icons.settings),
                backgroundColor: Colors.purple[300],
                foregroundColor: Colors.white,
                onTap: () {},
              ),
            ],
          ),
          title: SizedBox(
            child: GetBuilder<ScannerLogic>(builder: (context) {
              return Text(
                "Device Number: ${state.deviceNum}",
                style: const TextStyle(color: Colors.black),
              );
            }),
          ),
          subtitle: SizedBox(child: GetBuilder<ScannerLogic>(
            builder: (context) {
              return Text(
                state.status,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              );
            },
          )),
        ),
      )
    ],
  );
}
