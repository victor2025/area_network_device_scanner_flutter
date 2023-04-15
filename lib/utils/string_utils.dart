import 'package:area_network_device_scanner/entity/config_entity.dart';

class StringUtils{
  // 保证输入合法
  static String makeInputValid(String input){
    // 符号/空格/换行替换
    input = input.replaceAll(RegExp("，|;"), ",")
        .replaceAll(RegExp(" |\n"), "");
    return input;
  }

  static String parseCompanyName(String input){
    if(ConfigEntity.CONFIG.showFullCompanyName){
      input = input.replaceAll(".","")
          .replaceAll(",", "")
          .replaceAll(RegExp("(Co Ltd)|(CO LTD)|(COLTD)|CoLtd"), "")
          .replaceAll("TECHNOLOGIES", "Technologies")
          .trim();
    }else{
      input = input.split(" ")[0];
    }
    return input;
  }
}