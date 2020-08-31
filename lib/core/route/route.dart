import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/core/storage/global_storage.dart';
import 'package:flutter_news/core/utils/screen_util.dart';
import 'package:flutter_news/ui/pages/sign_in/sign_in.dart';
import 'package:flutter_news/ui/pages/sign_up/sign_up.dart';
import 'package:flutter_news/ui/pages/welcome/welcome.dart';

class LYRoute {
  static const initialRoute = LYWelcomePage.routeName;

  static final routes = {
    LYWelcomePage.routeName: (context) => LYWelcomePage(),
    LYSignInPage.routeName: (context) => LYSignInPage(),
    LYSignUpPage.routeName: (context) => LYSignUpPage()
  };

  // ignore: top_level_function_literal_block
  static final onGenerateRoute = (RouteSettings settings) {
    return null;
  };

  // ignore: top_level_function_literal_block
  static final onUnknownRoute = (RouteSettings settings) {
    return null;
  };
  // ignore: top_level_function_literal_block
  static final onGenerateInitialRoutes = (String routeName) {
    return [MaterialPageRoute(builder: (context){
      LYScreenUtil.init(context, uiWidth: 376, uiHeight: 812);
      final welcome = GlobalStorage.showWelcome;
      final user = GlobalStorage.userProfile;
      if (welcome) {return LYWelcomePage();}
      else if (!welcome && user == null) {
        return LYSignInPage();
      } else {
        return LYSignUpPage();
      }
    })];
  };


}