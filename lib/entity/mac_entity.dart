class MacResult{

  String ip;
  String mac;
  String name;

  MacResult(this.ip, {this.mac= "unknown", this.name = "unknown"});

  static MacResult unknownResult(String ip){
    return MacResult(ip);
  }
}