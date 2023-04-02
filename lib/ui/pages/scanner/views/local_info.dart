import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/local_info_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

FutureBuilder<LocalInfo> getLocalInfoFutureBuilder() {
  return FutureBuilder(
    future: IpUtils.getLocalInfo(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        state.localIp = snapshot.data!.ip;
        state.localWifiName = snapshot.data!.wifiName;
        return _getLocalInfoBox(snapshot.data!);
      } else {
        return _getLocalInfoBox(LocalInfo.unknownInfo());
      }
    },
  );
}

const TextStyle titleStyle = TextStyle(fontSize: 16);
const TextStyle itemTitleStyle = TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400);
const TextStyle itemStyle = TextStyle(fontSize: 12, color: Colors.black);

Widget _getLocalInfoBox(LocalInfo info) {
  var systemIp = Row(
    children: [
      const Expanded(flex:2,child: Text(
        "System Ip:",
        style: itemTitleStyle,
      ),),
      Expanded(flex:3,child: SelectableText(info.ip, style: itemStyle,)),
    ],
  );

  var wifiName = Row(
    children: [
      const Expanded(
        flex:2,
        child: Text(
        "WiFi Name:",
        style: itemTitleStyle,
      ),),
      Expanded(
        flex:3,
        child: SelectableText(info.wifiName, style: itemStyle,)),
    ],
  );

  return Container(
    child: Column(
      children: [
        systemIp,
        wifiName,
      ],
    ),
  );
}
