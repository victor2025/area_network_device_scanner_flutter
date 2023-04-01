import 'package:area_network_device_scanner/api/scan_ip_api/scan_ip_api.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';

import 'device_card.dart';

FutureBuilder<PingResult> getPingFutureBuilder(String ip) {
  return FutureBuilder<PingResult>(
    future: IpScanner.scanIp(ip),
    builder: (BuildContext context, AsyncSnapshot<PingResult> snapshot) {
      if (snapshot.hasData) {
        PingResult data = snapshot.data!;
        if (data.isAccessible) {
          return getDeviceCard(data);
        } else {
          return ConstWidgets.EMPTY;
        }
      } else {
        return ConstWidgets.EMPTY;
        // return const SizedBox.shrink();
      }
    },
  );
}

// FutureBuilder<MacResult> getDeviceNameFutureBuilder(String ip){
//
// }