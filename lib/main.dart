import 'package:flutter/material.dart';
import 'package:flutter_news/app_init.dart';
import 'package:flutter_news/core/route/route.dart';
import 'package:flutter_news/ui/pages/welcome/welcome_page.dart';

void main() {
  appInit().then((_) =>
  runApp(MyApp())
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: LYRoute.routes,
      onGenerateRoute: LYRoute.onGenerateRoute,
      onUnknownRoute: LYRoute.onUnknownRoute,
      initialRoute: LYRoute.initialRoute,
      theme: ThemeData(primarySwatch: Colors.blue,brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark)
    );
  }
}