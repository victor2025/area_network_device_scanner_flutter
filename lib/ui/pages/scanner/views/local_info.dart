import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/entity/local_info_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const LocalInfoBox emptyLocalInfoBox = LocalInfoBox(ips: Status.UNKNOWN);

final state = Get.find<ScannerLogic>().state;

FutureBuilder<LocalInfo> getLocalInfoFutureBuilder() {
  return FutureBuilder(
    future: IpUtils.getLocalInfo(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        state.localInfo = snapshot.data!;
        return LocalInfoBox(
            ips: state.getLocalIpsAsString(),
        );
      }else{
        return emptyLocalInfoBox;
      }
    },
  );
}

// 本地信息
class LocalInfoBox extends StatelessWidget {
  const LocalInfoBox({Key? key, required this.ips}) : super(key: key);

  final String ips;

  final TextStyle _itemTitleStyle = const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.w700);
  final TextStyle _itemStyle = const TextStyle(fontSize: 10, color: Colors.white54);

  @override
  Widget build(BuildContext context) {
    return _getLocalInfoBox();
  }

  Widget _getLocalInfoBox() {

    return SelectableText.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${'localIp'.tr}: ",
            style: _itemTitleStyle,
          ),
          TextSpan(
            text: ips,
            style: _itemStyle,
          )
        ]
      ),
    );
  }
}
