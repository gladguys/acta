import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ATAlert {
  static void success(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}