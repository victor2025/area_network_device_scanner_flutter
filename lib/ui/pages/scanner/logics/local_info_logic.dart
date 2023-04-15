
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/state.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/views/local_info.dart';
import 'package:get/get.dart';

class LocalInfoLogic{

  final ScannerState state;

  LocalInfoLogic(this.state);

  void refreshLocalInfo(){
    state.localInfo = getLocalInfoFutureBuilder();
  }
}

