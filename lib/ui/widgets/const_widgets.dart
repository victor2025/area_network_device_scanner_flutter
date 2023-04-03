import 'package:flutter/material.dart';

class ConstWidgets{
  static const Widget EMPTY = SizedBox(height: 0,);
  static const Widget LOADING = Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black38),
        ),
      ));
  static const Widget EMPTY_TEXT = Center(
    child: SizedBox(
      child: Text("EMPTY",
        style: TextStyle(color: Colors.black38, fontSize: 25, fontWeight: FontWeight.w900),),
    ),
  );
}