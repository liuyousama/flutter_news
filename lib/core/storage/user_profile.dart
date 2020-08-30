import 'package:flutter/material.dart';
import 'package:flutter_news/core/storage/preference.dart';

class UserProfile {
  static const storageKey = "com.liuyousama.preference.user_profile";

  String accessToken;
  String displayName;
  List<String> channels;

  UserProfile({
    @required this.accessToken,
    this.displayName,
    this.channels,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      UserProfile(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        channels: List<String>.from(json["channels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "display_name": displayName,
    "channels": List<dynamic>.from(channels.map((x) => x)),
  };

  static UserProfile fromStorage() {
    final json = LYPreference.getJson(storageKey);
    if (json == null) return null;
    return UserProfile.fromJson(json);
  }

  toStorage() {
    final json = this.toJson();
    LYPreference.setJson(storageKey, json);
  }
}