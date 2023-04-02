import 'package:get/get.dart';
import 'logics/device_list_logic.dart' as device_list_logic;
import 'logics/local_info_logic.dart' as local_info_logic;
import 'state.dart';

class ScannerLogic extends GetxController {
  final ScannerState state = ScannerState();

  // 开始扫描
  startScan(){
    clearDeviceList();
    device_list_logic.scanIpRange();
    update();
  }

  // 清除列表
  clearDeviceList(){
    state.refresh();
    local_info_logic.refreshLocalInfo();
    update();
  }

}
