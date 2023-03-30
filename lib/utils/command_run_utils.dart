import 'dart:async';
import 'dart:io';

class CommandRunner {
  // 执行命令
  static Future<String> runCommand(String script) async {
    if (script.isEmpty) return "empty Command";
    // 解析命令
    List<String> cmdList = script.split(" ");
    String cmd = cmdList[0];
    List<String> args = [];
    if (cmdList.length > 1) {
      args = cmdList.sublist(1, cmdList.length);
    }
    // 开始执行
    var process = await Process.run(cmd, args).catchError((e) => print('$e'));
    return process.stdout;
  }
}
