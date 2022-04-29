import 'package:mini_project/model/user_model.dart';

class TokenResult {
  String? token;
  User? user;
  String? userId;

  TokenResult({this.token, this.user, this.userId});

  TokenResult.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class LoginInput {
  String? email;
  String? password;

  LoginInput({this.email, this.password});

  LoginInput.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class RegisterInput {
  String? firstName;
  String? email;
  String? password;

  RegisterInput({this.firstName, this.email, this.password});

  RegisterInput.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
