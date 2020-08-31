import 'package:flutter_news/core/model/error_model.dart';
import 'package:flutter_news/core/model/user/user_login_model.dart';
import 'package:flutter_news/core/model/user/user_profile.dart';
import 'package:flutter_news/core/network/http.dart';

Future<UserProfile> loginUser(String email, String pwd) async {
  final data = UserLoginModel(email: email, password: pwd).toJson();
  final res = await LYHttp().post("/user/login",
    params: data,
  );
  final user = UserProfile.fromJson(res);
  if (user == null) throw LYErrorModel(-1, "数据解析失败");
  return user;
}