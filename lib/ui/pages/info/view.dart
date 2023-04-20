import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(InfoLogic());
    final state = Get.find<InfoLogic>().state;

    return Container();
  }
}
