import 'package:flutter/material.dart';

class AlertTest extends StatelessWidget {
  const AlertTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var alert = AlertDialog(
      // titlePadding: EdgeInsets.all(10),
      elevation: 10,
      backgroundColor: Colors.pink,
      //背景颜色

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //设置形状

      title: const Text('我是标题'),
      // icon: Icon(Icons.work_rounded),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('我可以是文本内容我可以是文本内容我可以是文本内容我可以是文本内容'),
      ),
      contentTextStyle: const TextStyle(color: Colors.black),
      //文本内容的text样式
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('确定')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消')),
        ),
      ],
    );

    return const Placeholder();
  }
}
