import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/file_api.dart';
import 'package:mini_project/model/file_model.dart';
import 'package:mini_project/services/services.dart';

class FileUploadViewModel with ChangeNotifier {
  ApiResponse<File> _file = ApiResponse(status: ApiStatus.success);
  ApiResponse<File> get file => _file;

  void changeState(ApiResponse<File> state) {
    _file = state;
    notifyListeners();
  }

  Future<ApiResponse<File>> uploadFile({required FormData formData}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await FileAPI.upload(input: formData);
      changeState(ApiResponse<File>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeState(
          ApiResponse(
              status: ApiStatus.error,
              message:
                  (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic),
        );
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
      }
    }
    return Future.value(_file);
  }
}
