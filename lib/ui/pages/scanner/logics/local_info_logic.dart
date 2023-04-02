
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/local_info.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

void refreshLocalInfo(){
  state.localInfo = getLocalInfoFutureBuilder();
}