import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/model/news/category.dart';
import 'package:flutter_news/core/model/news/news_item.dart';
import 'package:flutter_news/core/model/news/news_list.dart';
import 'package:flutter_news/core/network/api/api.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/ui/pages/home/buildNewsChannel.dart';
import 'package:flutter_news/ui/pages/home/category_list.dart';
import 'package:flutter_news/ui/pages/home/news_item.dart';
import 'package:flutter_news/ui/pages/home/news_letter.dart';
import 'package:flutter_news/ui/pages/home/news_recommend.dart';

class LYHomePage extends StatefulWidget {
  static const routeName = "/home";
  @override
  _LYHomePageState createState() => _LYHomePageState();
}

class _LYHomePageState extends State<LYHomePage> {
  List<CategoryModel> categories;
  NewsItemModel recommend;
  NewsListModel newsList;

  int cateSelIndex = 0;

  int get newsCount {
    if (newsList != null) return newsList.items.length ?? 0;
    else return 0;
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }
  void _initData() async {
    // 分类数据：先尝试从磁盘缓存中读取数据
    categories= await NewsApi.getCategories();
    setState((){});
    // 3秒后尝试从网络上更新数据
    Timer(Duration(seconds: 3), () async {
      categories = await NewsApi.getCategories(refresh: true);
    });
    recommend = await NewsApi.getRecommend();
    setState((){});
    newsList = await NewsApi.getNewsList();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        LYCategoryListWidget(
          categories: categories,
          cateSelIndex: cateSelIndex,
          onTap: (index)=>setState(()=>cateSelIndex = index),
        ),
        Expanded(
          flex: 1,
          child: ListView.separated(
              itemBuilder: _listItemBuilder,
              separatorBuilder: _listSeparatorBuilder,
              itemCount: newsCount + 3
          ),
        )
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    if (index == 0) {
      return buildNewsRecommend(context, recommend);
    }else if (index == 1) {
      return buildNewsChannel(context);
    } else if (index<newsCount + 2) {
      return buildNewsItem(context, newsList.items[index-2]);
    } else {
      return buildNewsLetter(context);
    }
  }

  Widget _listSeparatorBuilder(BuildContext context, int index) {
    return Divider(height: 1.lyHeight, color: AppColor(context).borderColor1,);
  }
}
