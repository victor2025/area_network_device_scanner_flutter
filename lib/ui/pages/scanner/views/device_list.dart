import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'device_card.dart';

final state = Get.find<ScannerLogic>().state;

class DeviceListView extends StatelessWidget {
  const DeviceListView({Key? key, required this.data}) : super(key: key);

  final List<PingResult> data;

  @override
  Widget build(BuildContext context) {
    return _getDeviceListView(data);
  }

  ListView _getDeviceListView(List<PingResult> results){
    final List<Widget> cardList = [];
    for(int i = 0; i<results.length; i++){
      cardList.add(IndexedDeviceCard(data: results[i], index: i+1));
    }
    return ListView(
      children: cardList,
    );
  }
}
