import 'package:flutter/material.dart';

class ConstWidgets{
  static const Widget EMPTY = SizedBox(height: 0,);
  static const Widget LOADING = Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ));
}