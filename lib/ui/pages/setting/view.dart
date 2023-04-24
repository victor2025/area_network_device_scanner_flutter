import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/ui/pages/setting/widgets/counter_widget.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final logic = Get.put(SettingLogic());

    Future.delayed(Duration.zero, logic.refreshState());

    var cancelBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            logic.tapCancel();
            Navigator.of(context).pop(true);
          },
          child: Text('cancel'.tr)),
    );

    var saveBtn = Center(
      child: ElevatedButton(
          onPressed: () {
            logic.tapSave();
            Navigator.of(context).pop(true);
          },
          child: Text('save'.tr)),
    );

    var actions = Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(child: cancelBtn),
            Expanded(child: saveBtn),
          ],
        ));

    var dialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      //背景颜色
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //设置形状
      title: Text(
        'appSetting'.tr,
        style: StyleConfigs.alertTitleStyle,
      ),
      content: SettingContent(),
      actions: [actions],
    );
    return dialog;
  }
}

class SettingContent extends StatelessWidget {
  SettingContent({
    Key? key,
  }) : super(key: key);

  final logic = Get.find<SettingLogic>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width,
        height: height/2.5,
        child: ListView(children: _getConfigRows()));
  }

  List<Widget> _getConfigRows() {
    SettingState state = logic.state;

    // show company
    var companyRow = ConfigRow(
      name: 'showCompanySetting'.tr,
      configZone: GetBuilder<SettingLogic>(builder: (logic) {
        return Switch(
            value: state.showCompany,
            onChanged: (val) => logic.tapShowCompany());
      }),
    );

    var enableTimeoutRow = ConfigRow(
      name: 'enableTimeoutSetting'.tr,
      configZone: GetBuilder<SettingLogic>(builder: (logic) {
        return Switch(
            value: state.enableTimeout,
            onChanged: (val) => logic.tapEnableTimeout());
      }),
    );

    var scanTimeoutRow = GetBuilder<SettingLogic>(builder: (logic) {
      return state.enableTimeout?
      Column(
        children: [
          const Divider(),
          ConfigRow(
            name: 'scanTimeoutSetting'.tr,
            configZone: ButtonCounter(
                displayZone: Text("${state.scanTimeout}"),
                countDown: () => logic.tapTimeoutCountDown(),
                countUp: () => logic.tapTimeoutCountUp(),
            ),
          ),
        ],
      ):ConstWidgets.EMPTY;
    });

    var threadNumberRow = ConfigRow(
      name: 'threadNumberSetting'.tr,
      configZone: GetBuilder<SettingLogic>(builder: (logic) {
        return ButtonCounter(
          displayZone: Text("${state.threadNumber}"),
          countDown: () => logic.tapThreadCountDown(),
          countUp: () => logic.tapThreadCountUp(),
        );
      }),
    );

    // language row
    var languageRow = ConfigRow(
      name: 'languageSetting'.tr,
      configZone: GetBuilder<SettingLogic>(builder: (logic) {
        return TextButton(
          onPressed: () => logic.tapLanguage(),
          child: Text(state.isChinese ? "中文" : "English",
            style: const TextStyle(color: Colors.blue,),
          ),
        );
      }),
    );

    return [
      const Divider(color: Colors.black87,),
      companyRow,
      const Divider(),
      enableTimeoutRow,
      scanTimeoutRow,
      const Divider(),
      threadNumberRow,
      const Divider(),
      languageRow,
    ];
  }
}

class ConfigRow extends StatelessWidget {
  const ConfigRow({
    Key? key,
    required this.name,
    required this.configZone,
  }) : super(key: key);

  final String name;
  final Widget configZone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(
          name,
          style: const TextStyle(fontSize: 15),
        )),
        configZone,
      ],
    );
  }
}
