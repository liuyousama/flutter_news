import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';
import 'package:flutter_news/core/model/news/category.dart';

class LYCategoryListWidget extends StatefulWidget {
  // 分类列表
  final List<CategoryModel> categories;
  // 当前选择的分类
  final int cateSelIndex;
  // 点击某个分类之后执行的闭包
  final Function(int) onTap;

  const LYCategoryListWidget({Key key, this.categories, this.onTap, this.cateSelIndex}) : super(key: key);

  @override
  _LYCategoryListWidgetState createState() => _LYCategoryListWidgetState();
}

class _LYCategoryListWidgetState extends State<LYCategoryListWidget> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.categories == null ? Container()
        : SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.lyWidth),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor(context).borderColor1))
        ),
        child: Row(
          children: List.generate(widget.categories.length, (index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 9.lyWidth, vertical: 15.lyHeight),
            child: GestureDetector(
              onTap: (){
                // 点击某个分类的时候，计算offset，自动使被点击的offset滑动到最开始的位置
                var offset = 18.lyWidth * index;
                widget.categories.sublist(0, index).forEach((element) {
                  offset+=_getTextWidth(element.title);
                });
                offset = min(offset, _controller.position.maxScrollExtent);
                _controller.animateTo(
                    offset,
                    duration: Duration(milliseconds: 100+(offset/2).floor().abs()),
                    curve: Curves.linear);
                // 执行闭包
                widget.onTap(index);
              },
              child: Text(
                widget.categories[index].title,
                style: AppFont.montserratSemiBold(
                    18.lyFont,
                    widget.cateSelIndex!=index
                        ? AppColor(context).primaryText
                        : AppColor(context).primaryElement
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }

  double _getTextWidth(String value) {
    final painter = TextPainter(
        locale: Localizations.localeOf(context, nullOk: true),
        maxLines: 1,
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: value,
            style:AppFont.montserratSemiBold(18.lyFont, null)
        )

    );
    painter.layout(maxWidth: double.infinity);
    return painter.width;
  }
}
