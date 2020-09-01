import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/core/model/news/news_item.dart';
import 'package:flutter_news/ui/widgets/cached_image.dart';

Widget buildNewsRecommend(BuildContext context, NewsItemModel model) {

  return model == null ? Container() 
  : Container(
    width: 375.lyWidth,
    height: 490.lyHeight,
    padding: EdgeInsets.symmetric(horizontal: 20.lyWidth),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cachedImage(model.thumbnail,
          width: 335.lyWidth,
          height: 290.lyHeight,
          margin: EdgeInsets.only(top: 20.lyHeight)
        ),
        Container(
          margin: EdgeInsets.only(top: 14.lyHeight),
          child: Text(
            model.author,
            style: AppFont.avenirBook(14.lyFont, AppColor(context).thirdElementText),
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 10.lyHeight, bottom: 10.lyHeight),
          child: Text(
            model.title,
            style: AppFont.montserratSemiBold(24.lyFont, AppColor(context).primaryText),
          ),
        ),

        SizedBox(
          child: Row(
            children: [
              Text(
                model.category,
                style: AppFont.avenirBook(14.lyFont, AppColor(context).primaryElement),
              ),
              SizedBox(width: 15.lyWidth),
              Text(
                "•   ${model.addtime.month} ago",
                style: AppFont.avenirBook(14.lyFont, AppColor(context).thirdElementText),
              ),
              Spacer(),
              InkWell(
                onTap: (){},
                child: Icon(
                  Icons.more_horiz,
                  color: AppColor(context).primaryText,
                  size: 24.lyWidth,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}