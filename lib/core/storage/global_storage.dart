import 'package:flutter_news/core/storage/preference.dart';
import 'package:flutter_news/core/storage/storage_key.dart';
import 'package:flutter_news/core/model/user/user_profile.dart';

const ShowWelcomeStorageKey = "com.liuyousama.news.preference.showWelcome";

class GlobalStorage {
  /// 本地存储用户登录信息
  static UserProfile _userProfile;
  static UserProfile get userProfile {
    if (_userProfile == null) {
      final json = LYPreference.getJson(StorageKey.UserProfile);
      if (json == null) {return null;}
      _userProfile = UserProfile.fromJson(json);
    }
    return _userProfile;
  }
  static set userProfile(UserProfile profile) {
    _userProfile = profile;
    if (_userProfile==null) {
      LYPreference.remove(StorageKey.UserProfile);
    } else {
      LYPreference.setJson(StorageKey.UserProfile, _userProfile.toJson());
    }
  }
  /// 本地存储欢迎页是否显示
  static bool _showWelcome;
  static bool get showWelcome {
    if (_showWelcome == null) {
      _showWelcome = LYPreference.getBool(ShowWelcomeStorageKey) ?? true;
    }
    return _showWelcome;
  }
  static set showWelcome(bool value) {
    if (value == null) return;
    _showWelcome = value;
    LYPreference.setBool(ShowWelcomeStorageKey, value);
  }

}