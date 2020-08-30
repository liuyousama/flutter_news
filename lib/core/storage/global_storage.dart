import 'package:flutter_news/core/storage/user_profile.dart';

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
    profile.toStorage();
  }

}