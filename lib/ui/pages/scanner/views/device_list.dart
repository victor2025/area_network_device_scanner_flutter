
import 'package:area_network_device_scanner/api/ping_api/ping_api.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'device_card.dart';

final state = Get.find<ScannerLogic>().state;

FutureBuilder<PingResult> getPingFutureBuilder(String ip) {
  return FutureBuilder<PingResult>(
    future: IpScanner.scanIp(ip),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        PingResult data = snapshot.data!;
        // 若可访问且不是本设备，则添加对应card
        if (data.isAccessible&&data.ip!=state.localIp) {
          state.deviceNum++;
          return getDeviceCard(data);
        } else {
          return ConstWidgets.EMPTY;
        }
      } else {
        return ConstWidgets.EMPTY;
      }
    },
  );
}