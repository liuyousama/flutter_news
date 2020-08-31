import 'package:flutter/material.dart';
import 'package:flutter_news/core/storage/global_storage.dart';
import 'package:flutter_news/ui/pages/sign_in/sign_in.dart';

class LYHomePage extends StatefulWidget {
  static const routeName = "/home";
  @override
  _LYHomePageState createState() => _LYHomePageState();
}

class _LYHomePageState extends State<LYHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("首页"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: (){
          GlobalStorage.userProfile = null;
          Navigator.pushReplacementNamed(context, LYSignInPage.routeName);
        },
      ),
    );
  }
}
