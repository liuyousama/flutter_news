import 'package:flutter/material.dart';
import 'package:flutter_news/ui/pages/welcome/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: LYWelcomePage()
    );
  }
}