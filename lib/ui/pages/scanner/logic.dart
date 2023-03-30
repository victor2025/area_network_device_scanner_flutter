import 'package:area_network_device_scanner/api/arp_api/arp_api.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/wigets/device_list_widget.dart';
import 'package:get/get.dart';
import 'state.dart';

class ScannerLogic extends GetxController {
  final ScannerState state = ScannerState();

  // 获取arp缓存
  _getArpTable() {}

  startScan(){
    clearDeviceList();
    state.deviceListWidget = DeviceList(isOn:true, start: "192.168.0.0", end:"192.168.0.110");
    update();
  }

  clearDeviceList(){
    state.refresh();
    update();
  }

  testShow(String str) {
    state.testStr = str;
    update();
  }
}
