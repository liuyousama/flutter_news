import 'package:flutter/material.dart';
import 'package:flutter_news/app_init.dart';
import 'package:flutter_news/core/route/route.dart';
import 'package:flutter_news/core/storage/global_storage.dart';
import 'package:flutter_news/core/storage/user_profile.dart';
import 'package:flutter_news/ui/pages/sign_in/sign_in.dart';

void main() {
  appInit().then((_) =>
  runApp(MyApp())
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalStorage.userProfile = null;
    return MaterialApp(
      title: 'Flutter Demo',
      routes: LYRoute.routes,
      onGenerateRoute: LYRoute.onGenerateRoute,
      onGenerateInitialRoutes: LYRoute.onGenerateInitialRoutes,
      onUnknownRoute: LYRoute.onUnknownRoute,
      initialRoute: LYRoute.initialRoute,
      theme: ThemeData(primarySwatch: Colors.blue,brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark)
    );
  }
}