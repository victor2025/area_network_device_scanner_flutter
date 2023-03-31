import 'package:area_network_device_scanner/api/scan_ip_api/scan_ip_api.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:area_network_device_scanner/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

List<Widget> _getDeviceList(String start, String end) {
  List<Widget> list = [];
  // 将起止ip转为数字
  int startNum = NetworkUtils.ip2num(start);
  int endNum = NetworkUtils.ip2num(end);
  if (startNum > endNum) return list;
  // 开始扫描，若可以访问，则添加到list中
  for (int i = startNum; i <= endNum; i++) {
    list.add(getPingFutureBuilder(NetworkUtils.num2ip(i)));
  }
  return list;
}

FutureBuilder<PingResult> getPingFutureBuilder(String ip) {
  return FutureBuilder<PingResult>(
    future: IpScanner.scanIp(ip),
    builder: (BuildContext context, AsyncSnapshot<PingResult> snapshot) {
      if (snapshot.hasData) {
        PingResult data = snapshot.data!;
        if (data.isAccessible) {
          return _getDeviceCard(data);
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

Widget _getDeviceCard(PingResult res) {
  // return Text(ip);
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
            VerticalDivider(),
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
      ]));
}
