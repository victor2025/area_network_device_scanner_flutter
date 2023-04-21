import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'device_card.dart';

final state = Get.find<ScannerLogic>().state;

class DeviceListView extends StatelessWidget {
  const DeviceListView({
    Key? key,
    required this.cardList
  }) : super(key: key);

  final List<Widget> cardList;

  @override
  Widget build(BuildContext context) {
    return _getDeviceListView(cardList);
  }

  ListView _getDeviceListView(List<Widget> cardList){
    final List<Widget> newCardList = [];
    newCardList.addAll(cardList);
    return ListView(
      children: newCardList,
    );
  }
}
