
import 'package:flutter/material.dart';

class LYAppColor {
  final BuildContext context;
  LYAppColor(this.context);

  int get index {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? 1 : 0;
  }

  /// 主背景
  Color get primaryBackground =>
      [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 255, 255, 255)][index];
  /// 主文本
  Color get primaryText =>
      [Color.fromARGB(255, 45, 45, 47),Color.fromARGB(255, 45, 45, 47)][index];
  /// 主控件-背景
  Color get primaryElement =>
      [Color.fromARGB(255, 41, 103, 255),Color.fromARGB(255, 41, 103, 255)][index];
  /// 主控件-文字
  Color get primaryElementText =>
      [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 255, 255, 255)][index];
}