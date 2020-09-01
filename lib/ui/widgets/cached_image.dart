import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter/material.dart';

Widget cachedImage(String url,{
  double width = 48,
  double height = 48,
  BoxFit fit = BoxFit.cover,
  double radius = 6,
  EdgeInsets margin}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider)=> Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: imageProvider,
          fit: fit
        )
      ),
    ),
    placeholder: (context, url) {
      return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    },
  );
}