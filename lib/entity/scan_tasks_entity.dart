import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/string_utils.dart';

class ScanTasks{

  List<ScanTaskItem> taskList = [];

  int currIdx = 0;
  int maxIdx = 0;

  // 解析输入并生成任务列表
  static ScanTasks parseInput(String input){
    // 使输入合法
    input = StringUtils.makeInputValid(input);
    // 开始扫描
    var tasks = ScanTasks();
    List<String> taskStrings = input.split(",");
    for (String taskStr in taskStrings) {
      final ipList = taskStr.split("-");
      try{
        if(ipList.length==1&&IpUtils.isIpValid(ipList[0])){
          tasks.addTask(IpUtils.getAreaStart(ipList[0]), IpUtils.getAreaEnd(ipList[0]));
        }else if(ipList.length==2&&IpUtils.isRangeValid(ipList[0], ipList[1])){
          tasks.addTask(ipList[0], ipList[1]);
        }
      }catch(e){
        continue;
      }
    }
    tasks.maxIdx = tasks.taskList.length-1;
    return tasks;
  }

  void addTask(String start, String end){
    if(IpUtils.isRangeValid(start, end)){
      taskList.add(ScanTaskItem(start, end));
    }
  }

  ScanTaskItem? getNextTask(){
    if(hasNextTask()){
      return taskList[currIdx++];
    }
    return null;
  }

  bool hasNextTask(){
    return currIdx<=maxIdx;
  }

  int getTaskCount(){
    return taskList.length;
  }

  @override
  String toString() {
    String res = taskList.toString();
    res = res.substring(1,res.length-1);
    return res;
  }
}

class ScanTaskItem{
  String start;
  String end;

  ScanTaskItem(this.start,this.end);

  @override
  String toString() {
    return "$start-$end";
  }
}