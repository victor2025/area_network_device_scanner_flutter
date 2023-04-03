import 'dart:math';

class RandUtils{

  static Random random = Random();

  static int randRange(int start, int end){
    int res = start+random.nextInt(end-start);
    return res;
  }
}