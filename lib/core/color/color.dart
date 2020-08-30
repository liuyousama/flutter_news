
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

  /// 第二种控件-背景色 淡灰色
  Color get secondaryElement =>
      [Color.fromARGB(255, 246, 246, 246),Color.fromARGB(255, 246, 246, 246)][index];

  /// 第二种控件-文本 浅蓝色
  Color get secondaryElementText =>
      [Color.fromARGB(255, 41, 103, 255),Color.fromARGB(255, 41, 103, 255)][index];

  /// 第三种控件-背景色 石墨色
  Color get thirdElement =>
      [Color.fromARGB(255, 45, 45, 47),Color.fromARGB(255, 45, 45, 47)][index];

  /// 第三种控件-文本 浅灰色2
  Color get thirdElementText =>
      [Color.fromARGB(255, 141, 141, 142),Color.fromARGB(255, 141, 141, 142)][index];


  Color get borderColor1 =>
      [Color.fromARGB(255, 230, 230, 231),Color.fromARGB(255, 230, 230, 231)][index];

}