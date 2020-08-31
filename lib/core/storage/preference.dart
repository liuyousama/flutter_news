import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LYPreference {
  static SharedPreferences _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static setJson(String key, Map<String, dynamic> value) {
    assetInited();
    if (value == null){
      _preferences.remove(key);
      return;
    }
    final jsonStr = JsonEncoder().convert(value);
    _preferences.setString(key, jsonStr);
  }

  static setBool(String key, bool value) {
    assetInited();
    _preferences.setBool(key, value);
  }
  static getBool(String key) {
    assetInited();
    return _preferences.getBool(key);
  }

  static getJson(String key) {
    assetInited();
    final data = _preferences.get(key);
    if (data == null) {return null;}
    final jsonMap = JsonDecoder().convert(data);
    return jsonMap;
  }

  static assetInited() {
    assert(_preferences != null, "LYPreference还未被初始化(调用init方法)，该组件必须在APP启动之前完成初始化");
  }
}