import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tost {
  static void ShowTost({
    required String massage,
    required ToastGravity toastGravity,
    Color color = Colors.red,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
        msg: "${massage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastGravity,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: textColor,
        fontSize: 16.0);
  }
}
