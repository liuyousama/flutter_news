import 'package:flutter/material.dart';
import 'package:flutter_news/core/storage/preference.dart';

Future appInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LYPreference.init();
}