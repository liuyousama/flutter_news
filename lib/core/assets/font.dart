
import 'package:flutter/material.dart';

class AppFont {
  static TextStyle avenirBook(double size, Color color) {
    return TextStyle(
      fontFamily: "Avenir",
      fontWeight: FontWeight.normal,
      fontSize: size,
      color: color
    );
  }
  static TextStyle montserratSemiBold(double size, Color color) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        fontSize: size,
        color: color
    );
  }
  static TextStyle montserratMedium(double size, Color color) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500,
        fontSize: size,
        color: color
    );
  }
}