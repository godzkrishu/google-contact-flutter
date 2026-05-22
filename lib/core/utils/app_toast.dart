import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {

  static void showSuccess(String message) {
    _show(
      message,
      bgColor: const Color(0xFF1E8E3E),
    );
  }

  static void showError(String message) {
    _show(
      message,
      bgColor: const Color(0xFFD93025),
    );
  }

  static void showInfo(String message) {
    _show(
      message,
      bgColor: const Color(0xFF1A73E8),
    );
  }

  static void _show(
      String message, {
        required Color bgColor,
      }) {

    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}