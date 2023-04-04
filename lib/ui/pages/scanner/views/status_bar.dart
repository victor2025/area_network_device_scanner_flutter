import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/input_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

final logic = Get.find<ScannerLogic>();
final state = logic.state;

// 状态栏
class StatusBar extends StatelessWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getStatusBar();
  }

  // 获取状态栏
  Widget getStatusBar() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: const MainButton(),
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
}

// 主按钮
class MainButton extends StatelessWidget {
  const MainButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getMainButton(context);
  }

  Widget getMainButton(BuildContext context){
    return SpeedDial(
      backgroundColor: Colors.blueGrey[500],
      foregroundColor: Colors.white,
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
          backgroundColor: Colors.blueGrey[300],
          foregroundColor: Colors.white,
          onTap: () => InputPage.show(context),
        ),
        SpeedDialChild(
          child: const Icon(Icons.cleaning_services),
          backgroundColor: Colors.blueGrey[300],
          foregroundColor: Colors.white,
          onTap: () => logic.refreshAllState(),
        ),
        SpeedDialChild(
          child: const Icon(Icons.settings),
          backgroundColor: Colors.blueGrey[300],
          foregroundColor: Colors.white,
          onTap: () {},
        ),
      ],
    );
  }
}