import 'package:flutter/services.dart';

class VibrateUtils{
  static unitVibrate(){
    HapticFeedback.vibrate();
  }
}