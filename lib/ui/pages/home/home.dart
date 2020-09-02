import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_news/core/model/news/category.dart';
import 'package:flutter_news/core/model/news/news_item.dart';
import 'package:flutter_news/core/model/news/news_list.dart';
import 'package:flutter_news/core/network/api/api.dart';
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
    if (newsList != null) return newsList.items.length ?? 3;
    else return 5;
  }
  NewsItemModel getNewsItem(int index) {
    if (newsList == null) return null;
    else return newsList.items[index];
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
      setState((){});
    });
    // 延时：模拟网络速度缓慢的情况，出现骨架屏
    Timer(Duration(seconds: 5), () async {
      recommend = await NewsApi.getRecommend();
      setState((){});
    });
    Timer(Duration(seconds: 5), () async {
      newsList = await NewsApi.getNewsList();
      setState((){});
    });

//    recommend = await NewsApi.getRecommend();
//    setState((){});
//    newsList = await NewsApi.getNewsList();
//    setState((){});
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
          child: _buildCustomListView(context),
        )
      ],
    );
  }

  Widget _buildCustomListView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return buildNewsRecommend(context, recommend);
            },
            childCount: 1
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildNewsChannel(context);
              },
              childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return buildNewsItem(context, getNewsItem(index));
            },
            childCount: newsCount
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              print("开始构建邮件");
              return buildNewsLetter(context);
            },
            childCount: 1
          ),
        ),
      ],
    );
  }
}
