import 'package:area_network_device_scanner/utils/file_utils.dart';

RegExp ipReg = RegExp(r"(((\d)|([1-9]\d)|(1\d{2})|(2[0-4]\d)|(25[0-5]))\.){3}((\d)|([1-9]\d)|(1\d{2})|(2[0-4]\d)|(25[0-5]))");
RegExp macReg = RegExp(r"([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})");
main() async{
  String path = "/proc/net/arp";
  String resStr = await FileLoader.loadFileAsString(path);
  List<String> lines = resStr.split("\n");
  String line = lines[1];
  var ipMatch = ipReg.firstMatch(line);
  String ip = ipMatch!.group(0)!;
  var macMatch = macReg.firstMatch(line);
  String mac = macMatch!.group(0)!;
  print("done");
}