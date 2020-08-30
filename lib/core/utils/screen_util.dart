import 'package:flutter/material.dart';

class LYScreenUtil {
  static double _uiWidth = 750;
  static double _uiHeight = 828;
  static double _screenWidth;
  static double _screenHeight;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;
  static bool _allowScaleText = false;

  static void init(BuildContext context,
      {double uiWidth, double uiHeight, bool allowScaleText}) {
    _uiWidth = uiWidth ?? _uiWidth;
    _uiHeight = uiHeight ?? _uiHeight;
    _allowScaleText = allowScaleText ?? _allowScaleText;

    final query = MediaQuery.of(context);
    _screenWidth = query.size.width;
    _screenHeight = query.size.height;
    _statusBarHeight = query.padding.top;
    _bottomBarHeight = query.padding.bottom;
    _textScaleFactor = query.textScaleFactor;
  }

  static double get widthAdaptRatio => _screenWidth / _uiWidth;
  static double get heightAdaptRatio => _screenHeight / _uiHeight;
  static double get textAdaptRatio => widthAdaptRatio;

  static double widthAdapt(double width) {
    return width * widthAdaptRatio;
  }

  static double heightAdapt(double height) {
    return height * heightAdaptRatio;
  }

  static double fontAdapt(double size) {
    return _allowScaleText
        ? size * textAdaptRatio / _textScaleFactor
        : size * textAdaptRatio;
  }
}
