import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/auth_api.dart';
import 'package:mini_project/model/auth_model.dart';
import 'package:mini_project/model/user_model.dart';
import 'package:mini_project/services/services.dart';

class UserViewModel extends ChangeNotifier {
  ApiResponse<User>? _user = ApiResponse(status: ApiStatus.success);

  ApiResponse<User>? get user => _user;

  void changeState(ApiResponse<User>? state) {
    _user = state;
    notifyListeners();
  }

  Future<ApiResponse<User>> getMe() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await AuthAPI.getMe();
      changeState(ApiResponse<User>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeState(ApiResponse(
            status: ApiStatus.error,
            message:
                (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic));
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
      }
    }
    return Future.value(_user);
  }
}
