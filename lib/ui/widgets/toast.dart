import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_news/core/extensions/extension.dart';

class LYToast {
  static Widget _buildToast(BuildContext context, String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(message,style: TextStyle(
        fontSize: 20.lyFont,
        color: Colors.white,
        fontWeight: FontWeight.w500
      ),),
    );
  }

  static Future showToast(BuildContext context, String message) async {
    final fToast = FToast(context);
    fToast.removeQueuedCustomToasts();
    fToast.showToast(
      toastDuration: Duration(seconds: 1),
      gravity: ToastGravity.BOTTOM,
      child: _buildToast(context, message)
    );
    return Future.delayed(Duration(seconds: 1));
  }
}