import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LYPreference {
  static SharedPreferences _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static remove(String key) {
    _preferences.remove(key);
  }
  static setJson(String key, dynamic value) {
    assetInited();
    if (value == null){
      _preferences.remove(key);
      return;
    }
    final jsonStr = JsonEncoder().convert(value);
    if (jsonStr == null) return;
    _preferences.setString(key, jsonStr);
  }
  static getJson(String key) {
    assetInited();
    final data = _preferences.get(key);
    if (data == null) {return null;}
    final json = JsonDecoder().convert(data);
    return json;
  }
  static setBool(String key, bool value) {
    assetInited();
    if (value == null) {
      _preferences.remove(key);
      return;
    }
    _preferences.setBool(key, value);
  }
  static getBool(String key) {
    assetInited();
    return _preferences.getBool(key);
  }

  static assetInited() {
    assert(_preferences != null, "LYPreference还未被初始化(调用init方法)，该组件必须在APP启动之前完成初始化");
  }
}