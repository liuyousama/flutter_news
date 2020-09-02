import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

Widget skeleton({
  double height = 64,
  double width = 64,
  double radius = 6,
  EdgeInsets margin
}) {
  return SkeletonAnimation(
    child: Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(radius)
      ),
    ),
  );
}