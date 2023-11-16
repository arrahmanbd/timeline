import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void showSnackBar(
      {required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static void setStatusColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }
}
