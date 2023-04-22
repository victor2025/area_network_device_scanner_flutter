import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/local_info_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const LocalInfoBox emptyLocalInfoBox = LocalInfoBox(ips: Status.UNKNOWN, wifi: Status.UNKNOWN);

final state = Get.find<ScannerLogic>().state;

FutureBuilder<LocalInfo> getLocalInfoFutureBuilder() {
  return FutureBuilder(
    future: IpUtils.getLocalInfo(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        state.localIps = snapshot.data!.ips;
        state.localWifiName = snapshot.data!.wifiName;
        return LocalInfoBox(
            ips: state.getLocalIpsAsString(),
            wifi: state.localWifiName
        );
      }else{
        return emptyLocalInfoBox;
      }
    },
  );
}

// 本地信息
class LocalInfoBox extends StatelessWidget {
  const LocalInfoBox({Key? key, required this.ips, required this.wifi}) : super(key: key);

  final String ips;
  final String wifi;
  final TextStyle _itemTitleStyle = const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.w700);
  final TextStyle _itemStyle = const TextStyle(fontSize: 10, color: Colors.white54);

  @override
  Widget build(BuildContext context) {
    return _getLocalInfoBox(ips, wifi);
  }

  Widget _getLocalInfoBox(String ips, String wifi) {
    var systemIp = Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "${'localIp'.tr}:",
            style: _itemTitleStyle,
          ),
        ),
        Expanded(
            flex: 3,
            child: SelectableText(
              ips,
              style: _itemStyle,
            )),
      ],
    );

    var wifiName = Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "${'wifiName'.tr}:",
            style: _itemTitleStyle,
          ),
        ),
        Expanded(
            flex: 3,
            child: SelectableText(
              wifi,
              style: _itemStyle,
            )),
      ],
    );

    return Column(
      children: [
        systemIp,
        wifiName,
      ],
    );
  }
}
