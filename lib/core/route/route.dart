import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/ui/pages/welcome/welcome_page.dart';

class LYRoute {
  static const initialRoute = LYWelcomePage.routeName;

  static final routes = {
    LYWelcomePage.routeName: (context) => LYWelcomePage()
  };

  // ignore: top_level_function_literal_block
  static final onGenerateRoute = (RouteSettings settings) {
    print(settings.name);
    print(settings.arguments);
    return null;
  };

  // ignore: top_level_function_literal_block
  static final onUnknownRoute = (RouteSettings settings) {
    print(settings.name);
    print(settings.arguments);
    return null;
  };
}