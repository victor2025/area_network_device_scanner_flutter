import 'package:flutter/material.dart';

class ConstWidgets {
  static const Widget EMPTY = SizedBox(
    height: 0,
  );
  static const Widget LOADING = Center(
    child: SizedBox(
        height: 10,
        width: 10,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
      ),
    )
  );
  static const Widget EMPTY_TEXT = Center(
    child: SizedBox(
      child: Text(
        "EMPTY",
        style: TextStyle(
            color: Colors.blueGrey, fontSize: 25, fontWeight: FontWeight.w900),
      ),
    ),
  );
}
