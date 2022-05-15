import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/user_api.dart';
import 'package:mini_project/model/user_model.dart';
import 'package:mini_project/services/services.dart';

class UpdateProfilePictureViewModel with ChangeNotifier {
  ApiResponse<UserResult>? _user = ApiResponse(status: ApiStatus.success);
  ApiResponse<UserResult>? get user => _user;

  void changeUserState(ApiResponse<UserResult>? state, bool? notify) {
    _user = state;
    if (notify != null && notify) {
      notifyListeners();
    }
  }

  Future<ApiResponse<UserResult>> updateProfilePicture(
      {required String id, required UpdateProfilePictureInput input}) async {
    try {
      changeUserState(ApiResponse(status: ApiStatus.loading), false);
      final res = await UserAPI.updateProfilePicture(id: id, input: input);
      changeUserState(ApiResponse<UserResult>(data: res, status: ApiStatus.success), false);
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
