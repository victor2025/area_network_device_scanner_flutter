class ThreadUtils{
  static Future sleep(int millisecond) async{
    await Future.delayed(Duration(milliseconds: millisecond));
  }
}