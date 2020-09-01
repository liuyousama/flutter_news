import 'package:flutter/material.dart';
import 'package:flutter_news/core/assets/color.dart';
import 'package:flutter_news/core/assets/font.dart';
import 'package:flutter_news/core/extensions/extension.dart';

Widget buildNewsLetter(BuildContext context) {
  return Container(
    height: 259.lyHeight,
    width: 375.lyWidth,
    color: AppColor(context).secondaryElement,
    child: Column(
      children: [
        // 标题
        Container(
          height: 60.lyHeight,
          padding: EdgeInsets.symmetric(horizontal: 20.lyWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Newsletter", style: AppFont.montserratSemiBold(18.lyFont, AppColor(context).primaryText),),
              InkWell(
                child: Icon(Icons.close, size: 24.lyWidth, color: AppColor(context).forthElement,),
                // TODO: 点击关闭按钮
                onTap: ()=>print("关闭"),
              )
            ],
          ),
        ),
        // 邮箱输入框
        _buildEmailField(context),
        // 订阅按钮
        Container(
          height: 44.lyHeight,
          width: 335.lyWidth,
          margin: EdgeInsets.symmetric(horizontal: 20.lyWidth, vertical: 15.lyHeight),
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.lyWidth)),
            child: Text(
              "Subscribe",
              style: AppFont.montserratSemiBold(18.lyFont, AppColor(context).primaryBackground),
            ),
            onPressed: ()=>print("订阅"),
            color: AppColor(context).primaryElement,
          ),
        ),
        // 协议同意文字
        Container(
          height: 42.lyHeight,
          width: 260.lyWidth,
          margin: EdgeInsets.only(top: 15.lyHeight),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "By clicking on Subscribe button you\nagree to accept ",
                  style: AppFont.avenirBook(14.lyFont, AppColor(context).forthElement).copyWith(height: 1.28)
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: ()=>print("隐私策略"),
                    child: Text(
                      "Privacy Policy",
                      style: AppFont.avenirBook(14.lyFont, AppColor(context).secondaryElementText).copyWith(height: 1.28),
                    ),
                  )
                )
              ]
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}

Widget _buildEmailField(BuildContext context) {
  return Container(
    height: 44.lyHeight,
    margin: EdgeInsets.symmetric(horizontal: 20.lyWidth),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.lyWidth),
      color: AppColor(context).primaryBackground,
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: AppFont.avenirBook(18.lyFont, AppColor(context).primaryText),
        border: InputBorder.none,
        prefix: SizedBox(width: 20.lyWidth,)
      ),
    ),
  );
}