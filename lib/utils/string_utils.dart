class StringUtils{
  // 保证输入合法
  static String makeInputValid(String input){
    // 半全角替换
    input = input.replaceAll("，", ",");
    // 空格替换
    input = input.replaceAll(" ", "");
    return input;
  }
}