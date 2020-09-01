import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/icon_font.dart';
import 'package:flutter_news/ui/pages/home/home.dart';

List<BottomNavigationBarItem> tabBarItems(BuildContext context){
  return [
    _buildTabItem(context, Iconfont.home, "main"),
    _buildTabItem(context, Iconfont.grid, "category"),
    _buildTabItem(context, Iconfont.tag, "tag"),
    _buildTabItem(context, Iconfont.me, "my")
  ];
}

final List<String> tabTitles = [
  'Welcome',
  'Cagegory',
  'Bookmarks',
  'Account'
];

List<Widget> pages = [
  LYHomePage(),
  LYHomePage(),
  LYHomePage(),
  LYHomePage()
];

BottomNavigationBarItem _buildTabItem(BuildContext context, IconData icon, String title) {
  return BottomNavigationBarItem(
    icon: Icon(icon, color: AppColor(context).tabBarElement),
    activeIcon: Icon(icon, color: AppColor(context).primaryElement,),
    title: Text(title),
    backgroundColor: AppColor(context).primaryBackground,
  );
}