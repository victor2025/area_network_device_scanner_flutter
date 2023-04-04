import 'package:area_network_device_scanner/config/values.dart';

class StringUtils{
  // 保证输入合法
  static String makeInputValid(String input){
    // 符号/空格/换行替换
    input = input.replaceAll(RegExp("，|;"), ",")
        .replaceAll(RegExp(" |\n"), "");
    return input;
  }

  static String parseCompanyName(String input){
    if(ConfigValues.showFullCompanyName){
      input = input.replaceAll(".","")
          .replaceAll(",", "")
          .replaceAll(RegExp("(Co Ltd)|(CO LTD)|(COLTD)"), "")
          .replaceAll("TECHNOLOGIES", "Technologies")
          .trim();
    }else{
      input = input.split(" ")[0];
    }
    return input;
  }
}