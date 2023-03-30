import 'package:area_network_device_scanner/ui/pages/scanner/wigets/device_list_widget.dart';
import 'package:get/get.dart';
import 'state.dart';

class ScannerLogic extends GetxController {
  final ScannerState state = ScannerState();

  // 获取arp缓存
  _getArpTable() {}

  startScan(){
    state.refresh();
    update();
    state.deviceListWidget = DeviceList(isOn:true, start: "113.54.148.0", end:"113.54.148.200");
    update();
  }

  testShow(String str) {
    state.testStr = str;
    update();
  }
}
