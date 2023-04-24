import 'package:area_network_device_scanner/config/config_values.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/string_utils.dart';

class ScanTasks{

  List<ScanTaskItem> taskList = [];

  int _scanCnt = 0;
  int _currIdx = 0;
  int _maxIdx = 0;

  // 解析输入并生成任务列表
  static ScanTasks parseInput(String input){
    // 使输入合法
    input = StringUtils.makeInputValid(input);
    // 开始扫描
    var tasks = ScanTasks();
    List<String> taskStrings = input.split(",");
    for (String taskStr in taskStrings) {
      final ipList = taskStr.split("-");
      String start;
      String end;
      try{
        if(ipList.length==1&&IpUtils.isIpValid(ipList[0])){
          start = IpUtils.getAreaStart(ipList[0]); end = IpUtils.getAreaEnd(ipList[0]);
          _addTaskSlices(tasks,start,end);
        }else if(ipList.length==2&&IpUtils.isRangeValid(ipList[0], ipList[1])){
          start = ipList[0]; end = ipList[1];
          _addTaskSlices(tasks,start,end);
        }
      }catch(e){
        continue;
      }
    }
    tasks._maxIdx = tasks.taskList.length-1;
    return tasks;
  }

  // 添加任务切片
  static void _addTaskSlices(ScanTasks tasks, String start, String end){
    int startNum = IpUtils.ip2num(start);
    int endNum = IpUtils.ip2num(end);
    int sliceSize = ConfigValues.CONFIG.taskSliceSize;
    // 若小于切片大小，则直接添加任务
    if(endNum-startNum+1<=sliceSize){
      tasks.addTaskByNum(startNum,endNum);
    }else{
      int currStart = startNum;
      int currEnd = currStart+sliceSize-1;
      // 循环添加
      while(currEnd<=endNum){
        tasks.addTaskByNum(currStart, currEnd);
        currStart = currEnd+1;
        currEnd = currStart+sliceSize-1;
      }
      // 最后添加剩余部分
      tasks.addTaskByNum(currStart,endNum);
    }
  }

  void addTaskByNum(int startNum, int endNum){
    if(startNum<=endNum){
      _scanCnt+=(endNum-startNum+1);
      taskList
          .add(ScanTaskItem(IpUtils.num2ip(startNum), IpUtils.num2ip(endNum)));
    }
  }

  ScanTaskItem? getNextTask(){
    if(hasNextTask()){
      return taskList[_currIdx++];
    }
    return null;
  }

  bool hasNextTask(){
    return _currIdx<=_maxIdx;
  }

  int getTaskCount(){
    return taskList.length;
  }

  int getScanCount(){
    return _scanCnt;
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