import 'dart:io';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'logic.dart';

class ProtocolPage extends StatelessWidget {
  const ProtocolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProtocolLogic());
    final state = Get.find<ProtocolLogic>().state;

    var agreeBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            logic.shownProtocol();
            Navigator.of(context).pop(true);
          },
          child: const Text('同意')),
    );

    var quitBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            exit(0);
          },
          child: const Text('退出')),
    );

    var actions = Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(child: agreeBtn),
            Expanded(child: quitBtn),
          ],
        )
    );

    var dialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white, //背景颜色
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)), //设置形状
      title: const Text("用户协议与隐私条款",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: ProtocolContent(
        protocolLogic: logic,
      ),
      actions: [
        actions,
      ],
    );
    return dialog;
  }
}

class ProtocolContent extends StatelessWidget {
  const ProtocolContent({Key? key, required this.protocolLogic}) : super(key: key);

  final ProtocolLogic protocolLogic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _getProtocolFutureBuilder(),
    );
  }

  FutureBuilder<String> _getProtocolFutureBuilder(){
    return FutureBuilder<String>(
      future: protocolLogic.loadProtocol(),
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
}



