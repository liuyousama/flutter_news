import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/core/model/news/news_item.dart';
import 'package:flutter_news/ui/widgets/cached_image.dart';

Widget buildNewsItem(BuildContext context, NewsItemModel model) {
  return model == null ? Container()
  : Container(
    padding: EdgeInsets.symmetric(horizontal: 20.lyWidth, vertical: 20.lyHeight),
    height: 161.lyHeight,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColor(context).borderColor1))
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cachedImage(
          model.thumbnail,
          width: 121.lyWidth,
          height: 121.lyHeight
        ),
        SizedBox(width: 20.lyWidth),
        SizedBox(
          width: 194.lyWidth,
          child: Column(
            children: [
              Text(
                model.author,
                style: AppFont.avenirBook(14.lyFont, AppColor(context).thirdElementText)
              ),
              SizedBox(height: 11.lyHeight,),
              Text(
                model.title,
                maxLines: 3,
                style: AppFont.montserratMedium(16.lyFont, AppColor(context).primaryText),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.category,
                    style: AppFont.avenirBook(14.lyFont, AppColor(context).primaryElement)
                  ),
                  SizedBox(width: 15.lyWidth,),
                  Text(
                    "• 7m ago",
                    style: AppFont.avenirBook(14.lyFont, AppColor(context).thirdElementText),
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(
                      Icons.more_horiz,
                      color: AppColor(context).primaryText,
                      size: 24.lyWidth,
                    ),
                  )
                ],
              )

            ],
          ),
        )
      ],
    ),
  );
}