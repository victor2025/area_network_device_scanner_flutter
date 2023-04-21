import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'logic.dart';

class MarkdownAlertPage extends StatelessWidget {
  const MarkdownAlertPage({Key? key, required this.assertPath}) : super(key: key);

  final String assertPath;

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MarkdownAlertLogic());

    var backBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('返回')),
    );

    var dialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white, //背景颜色
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)), //设置形状
      content: MarkdownAlertContent(
        logic: logic,
        assertPath: assertPath,
      ),
      actions: [
        backBtn
      ],
    );
    return dialog;
  }
}

class MarkdownAlertContent extends StatelessWidget {
  const MarkdownAlertContent({Key? key, required this.logic, required this.assertPath}) : super(key: key);

  final MarkdownAlertLogic logic;
  final String assertPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _getMarkdownFutureBuilder(assertPath),
    );
  }

  FutureBuilder<String> _getMarkdownFutureBuilder(String assertPath){
    return FutureBuilder<String>(
      future: logic.loadMarkdownContent(assertPath),
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



