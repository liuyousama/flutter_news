import 'package:flutter_news/core/storage/preference.dart';
import 'package:flutter_news/core/storage/user_profile.dart';

const ShowWelcomeStorageKey = "com.liuyousama.news.preference.showWelcome";

class GlobalStorage {
  static UserProfile _userProfile;
  static UserProfile get userProfile {
    if (_userProfile == null) {
      _userProfile = UserProfile.fromStorage();
    }
    return _userProfile;
  }
  static set userProfile(UserProfile profile) {
    _userProfile = profile;
    if (_userProfile==null) {
      LYPreference.setJson(UserProfile.storageKey, null);
      return;
    }
    profile.toStorage();
  }

  static bool _showWelcome;
  static bool get showWelcome {
    if (_showWelcome == null) {
      _showWelcome = LYPreference.getBool(ShowWelcomeStorageKey) ?? true;
    }
    return _showWelcome;
  }
  static set showWelcome(bool value) {
    _showWelcome = value;
    LYPreference.setBool(ShowWelcomeStorageKey, value);
  }

}