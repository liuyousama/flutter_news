import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LYPreference {
  static SharedPreferences _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static setJson(String key, Map<String, dynamic> value) {
    assetInited();
    final jsonStr = JsonEncoder().convert(value);
    _preferences.setString(key, jsonStr);
  }

  static getJson(String key) {
    assetInited();
    final data = _preferences.get(key);
    final jsonMap = JsonDecoder().convert(data);
    return jsonMap;
  }

  static assetInited() {
    assert(_preferences != null, "LYPreference还未被初始化(调用init方法)，该组件必须在APP启动之前完成初始化");
  }
}