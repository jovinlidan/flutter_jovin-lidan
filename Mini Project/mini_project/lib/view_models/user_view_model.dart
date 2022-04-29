import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/auth_api.dart';
import 'package:mini_project/model/user_model.dart';
import 'package:mini_project/services/services.dart';

class UserViewModel with ChangeNotifier {
  ApiResponse<User>? _user = ApiResponse(status: ApiStatus.success);
  ApiResponse<User>? get user => _user;

  void changeUserState(ApiResponse<User>? state, bool? notify) {
    _user = state;
    if (notify != null && notify) {
      notifyListeners();
    }
  }

  Future<ApiResponse<User>> getMe() async {
    try {
      changeUserState(ApiResponse(status: ApiStatus.loading), false);
      final res = await AuthAPI.getMe();
      changeUserState(ApiResponse<User>(data: res, status: ApiStatus.success), false);
    } catch (e) {
      if (e is DioError) {
        changeUserState(
            ApiResponse(
                status: ApiStatus.error,
                message:
                    (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic),
            false);
      } else {
        changeUserState(ApiResponse(status: ApiStatus.error, message: "Error!!!"), false);
      }
    }
    return Future.value(_user);
  }
}
