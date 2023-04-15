import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logics/protocol_logic.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ProtocolDialog extends StatelessWidget {
  const ProtocolDialog({Key? key, required this.protocolLogic}) : super(key: key);

  final ProtocolLogic protocolLogic;

  FutureBuilder<String> getPrivacyProtocolFutureBuilder(){
    return FutureBuilder<String>(
      future: protocolLogic.loadPrivacyProtocol(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return MarkdownWidget(
            data: snapshot.data!,
            config: StyleConfigs.markdownConfig,
          );
        }else{
          return ConstWidgets.EMPTY;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var dialog = AlertDialog(
      elevation: 10,
      backgroundColor: Colors.white, //背景颜色
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)), //设置形状
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: getPrivacyProtocolFutureBuilder(),
      ),
      contentTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 5
      ), //文本内容的text样式
      actions: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                protocolLogic.shownProtocol();
                Navigator.of(context).pop(true);
              },
              child: const Text('知道了')),
        ),
      ],
    );

    var window = Container(
      margin: EdgeInsets.zero,
      child: dialog,
    );

    return window;
  }
}
