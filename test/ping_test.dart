import 'package:area_network_device_scanner/utils/codec_utils.dart';
import 'package:dart_ping/dart_ping.dart';

main() async{
  final Ping ping = Ping("www.baidu.com", count: 3, encoding: CodecUtils.getCodec());
  ping.stream.listen((event) {
    print(event);
  });
}