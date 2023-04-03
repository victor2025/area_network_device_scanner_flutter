import 'package:area_network_device_scanner/api/mac_api/mac_api.dart';
import 'package:area_network_device_scanner/config/values.dart';
import 'package:area_network_device_scanner/entity/mac_entity.dart';
import 'package:area_network_device_scanner/entity/ping_entity.dart';
import 'package:area_network_device_scanner/ui/pages/scanner/logic.dart';
import 'package:area_network_device_scanner/ui/widgets/const_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final state = Get.find<ScannerLogic>().state;

const TextStyle titleStyle = TextStyle(fontSize: 12, color: Colors.grey);
const TextAlign titleAlign = TextAlign.right;
const TextStyle contentStyle = TextStyle(fontSize: 12);
const EdgeInsets cardMargin = EdgeInsets.fromLTRB(6, 2, 6, 2);


Widget getIndexedDeviceCard(PingResult res, int ind){
  var index = Container(
    padding: const EdgeInsets.only(left: 10),
    child: Text("$ind",
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
  return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      elevation: 20,
      margin: cardMargin,
      child: Row(
        children: [
          index,
          Expanded(child: _getCardContent(res),)
        ],
      )
  );
}

Widget getDeviceCard(PingResult res) {

  return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      elevation: 20,
      margin: cardMargin,
      child: _getCardContent(res),
  );
}

Widget _getCardContent(PingResult res){
  // ip
  var ipRow = ListTile(
    title: const Text("Ip Address:", style: titleStyle),
    subtitle: SelectableText(res.ip,
        style: const TextStyle(fontSize: 18, color: Colors.black,)),
  );

  // 延迟
  var delayRow = Row(
    children: [
      const Expanded(flex:1,child: Text("Delay:",style: titleStyle,)),
      Expanded(flex:2,child: Text("${res.rtt} ms",style: contentStyle,)),
    ],
  );

  return Row(
    children: [
      Expanded(
        flex: 3 ,
        child: ipRow,
      ),
      Expanded(
          flex: 4,
          child:Column(
            children: [
              delayRow,
              _getMacInfoFutureBuilder(res.ip),
            ],
          )
      ),
    ],
  );
}

// 获取mac信息
FutureBuilder<MacResult> _getMacInfoFutureBuilder(String ip){
  return FutureBuilder<MacResult>(
    future: MacApi.getMacResultByIp(ip),
    builder: (context, snapshot){
      if(snapshot.hasData){
        return _getMacInfoColumn(snapshot.data!);
      }else{
        return _getMacInfoColumn(MacResult.unknownResult(ip));
      }
    },
  );
}

Widget _getMacInfoColumn(MacResult data){
  // mac地址
  var macRow = Row(
    children: [
      const Expanded(flex:1,child: Text("Mac:",style: titleStyle,)),
      Expanded(flex: 2,child: SelectableText(data.mac,style: contentStyle,)),
    ],
  );

  // 公司名称
  var companyRow = ConfigValues.showDeviceCompany?Row(
    children: [
      const Expanded(flex:1,child: Text("Company:",style: titleStyle,)),
      Expanded(flex:2,child: SelectableText(data.name,style: contentStyle,)),
    ],
  ):ConstWidgets.EMPTY;

  return Column(
    children: [
      macRow,
      companyRow,
    ],
  );
}