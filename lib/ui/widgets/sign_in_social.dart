import 'package:flutter/material.dart';
import 'package:flutter_news/core/color/color.dart';
import 'package:flutter_news/core/extensions/extension.dart';

class SignInSocialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildExplainText(context),
        _buildSocialLogin(context)
      ],
    );
  }

  /// 说明文字
  Widget _buildExplainText(BuildContext context) {
    const explainText = "Or sign in with social networks";
    return Container(
      margin: EdgeInsets.only(bottom: 20.lyHeight),
      child: Text(explainText, style: TextStyle(
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: 16.lyFont,
          color: LYAppColor(context).primaryText
      )),
    );
  }
  /// 社交登录按钮
  Widget _buildSocialLogin(BuildContext context) {
    final btn = (String icon, String url) {
      return GestureDetector(
        onTap: ()=>print("点击了$url"),
        child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 88.lyWidth,
                height: 44.lyHeight,
                decoration: BoxDecoration(
                    color: LYAppColor(context).primaryBackground,
                    borderRadius: BorderRadius.circular(6.lyWidth),
                    border: Border.all(
                        color: LYAppColor(context).borderColor1,
                        width: 1.lyWidth
                    )
                ),
              ),
              Image.asset("assets/images/$icon.png",
                height: 24.lyWidth,
                width: 24.lyWidth,
                fit: BoxFit.fill,
              )
            ]

        ),
      );
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        btn("signin_twitter", "推特"), SizedBox(width: 15.lyWidth,),
        btn("signin_google", "谷歌"), SizedBox(width: 15.lyWidth,),
        btn("signin_facebook", "Facebook")
      ],
    );
  }
}
