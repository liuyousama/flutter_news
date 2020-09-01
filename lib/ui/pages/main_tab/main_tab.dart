import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/ui/pages/main_tab/initial.dart';

class LYMainTabPage extends StatefulWidget {
  static const routeName = "/maintab";
  @override
  _LYMainTabPageState createState() => _LYMainTabPageState();
}

class _LYMainTabPageState extends State<LYMainTabPage> {
  int currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor(context).primaryBackground,
      appBar: _buildAppBar(context, currentIndex),
      body: _buildPageView(context),
      bottomNavigationBar: BottomNavigationBar(
        items: tabBarItems(context),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 24,
        currentIndex: currentIndex,
        selectedFontSize: 14.lyFont,
        unselectedFontSize: 14.lyFont,
        onTap: _onChangeIndex,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, int index) {
    return AppBar(
      title: Text(
        tabTitles[index],
        style: AppFont.montserratSemiBold(18.lyFont, AppColor(context).primaryText),
      ),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.search, size: 22.lyFont, color: AppColor(context).primaryText,),
          onPressed: ()=>print("搜索"),
        )
      ],
      backgroundColor: AppColor(context).primaryBackground,
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: pages.map((e) => SizedBox.expand(child: e)).toList(),
      onPageChanged: _onChangePage,
    );
  }

  _onChangeIndex(int index) {
    _pageController.jumpToPage(index);
  }
  _onChangePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
