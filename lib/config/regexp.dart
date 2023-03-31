
class Regs{
  // ping
  static final RegExp WIN_PING_RCVD = RegExp(r"已接收 = [0-9]");
  static final RegExp WIN_PING_RTT = RegExp(r"平均 = [0-9]ms");

  // arp
  static final RegExp IP = RegExp(r"((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})(\.((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})){3}");
  static final RegExp MAC = RegExp(r"([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})");
  static final RegExp NUM = RegExp(r"(\-|\+)?\d+(\.\d+)?");
  static final RegExp POS_INT = RegExp(r"[1-9]\d*|0$");


}