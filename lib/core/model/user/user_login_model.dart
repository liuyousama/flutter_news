class UserLoginModel {
  final String email;
  final String password;

  UserLoginModel({this.email, this.password});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}