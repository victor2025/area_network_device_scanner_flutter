import 'package:area_network_device_scanner/api/ping_api/ping_api.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'device_card.dart';

final state = Get.find<ScannerLogic>().state;

class DeviceListView extends StatelessWidget {
  const DeviceListView({Key? key, required this.data}) : super(key: key);

  final List<PingResult> data;

  @override
  Widget build(BuildContext context) {
    return getDeviceListView(data);
  }

  Widget getDeviceListView(List<PingResult> results) {
    // 若为空，则返回empty
    if (results.isEmpty) return ConstWidgets.EMPTY_TEXT;
    // 若不为空，则返回结果
    List<Widget> list = state.deviceList;
    for (var data in results) {
      if (data.isAccessible && !state.localIps.contains(data.ip)) {
        state.deviceNum++;
        list.add(IndexedDeviceCard(data:data, index: state.deviceNum));
      }
    }
    return ListView(
      children: list,
    );
  }
}
