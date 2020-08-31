import 'package:flutter/material.dart';
import 'package:flutter_news/core/extensions/extension.dart';

import 'package:flutter_news/core/color/color.dart';
import 'package:flutter_news/core/storage/global_storage.dart';
import 'package:flutter_news/core/utils/screen_util.dart';
import 'package:flutter_news/ui/pages/sign_in/sign_in.dart';

const _headerDetailText = "The best of news channels all in one place. Trusted sources and personalized news for you.";
const _featureText1 = "Compelling photography and typography provide a beautiful reading";
const _featureText2 = "Sector news never shares your personal data with advertisers or publishers";
const _featureText3 = "You can get Premium to unlock hundreds of publications";

class LYWelcomePage extends StatelessWidget {
  static const routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LYAppColor(context).primaryBackground,
      body: Column(
        children: [
          _buildHeaderTitle(context),
          _buildHeaderDetails(context),
          SizedBox(height: (86-40).lyHeight),
          _buildFeatureItem(context, "feature1", _featureText1),
          _buildFeatureItem(context, "feature2", _featureText2),
          _buildFeatureItem(context, "feature3", _featureText3),
          _buildStartBtn(context)
        ],
      ),
    );
  }

  Widget _buildHeaderTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (60+44).lyHeight),
      child: Text("Features", style: TextStyle(
        color: LYAppColor(context).primaryText,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        fontSize: 24.lyFont,
      )),
    );
  }

  Widget _buildHeaderDetails(BuildContext context) {
    return Container(
      width: 242.lyWidth,
      height: 70.lyHeight,
      margin: EdgeInsets.only(top: 14.lyHeight),
      child: Text(_headerDetailText, style: TextStyle(
        color: LYAppColor(context).primaryText,
        fontFamily: "Avenir",
        fontWeight: FontWeight.normal,
        fontSize: 16.lyFont
      )),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String img, String text) {
    return Container(
      margin: EdgeInsets.only(top: 40.lyHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/$img.png",
            height: 80.lyHeight,
            width: 80.lyWidth,
            fit: BoxFit.fill,
          ),
          Container(
            width: 195.lyWidth,
            height: 70.lyHeight,
            margin: EdgeInsets.only(left: 20.lyWidth),
            child: Text(text, style: TextStyle(
              color: LYAppColor(context).primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: 16.lyFont
            )),
          )
        ],
      ),
    );
  }

  Widget _buildStartBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 91.lyHeight),
      width: 295.lyWidth,
      height: 44.lyHeight,
      child: FlatButton(
        color: LYAppColor(context).primaryElement,
        textColor: LYAppColor(context).primaryElementText,
        child: Text("Get Started", style: TextStyle(fontSize: 18.lyFont)),
        onPressed: (){
          GlobalStorage.showWelcome = false;
          Navigator.of(context).pushReplacementNamed(LYSignInPage.routeName);
          print("点击了开始按钮");
        },
      ),
    );
  }
}
