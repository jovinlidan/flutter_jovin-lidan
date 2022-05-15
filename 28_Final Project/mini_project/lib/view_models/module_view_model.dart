import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/module_api.dart';
import 'package:mini_project/model/module_model.dart';
import 'package:mini_project/services/services.dart';

class ModuleViewModel with ChangeNotifier {
  ApiResponse<Module>? _module = ApiResponse(status: ApiStatus.success);
  ApiResponse<Module>? get module => _module;

  void changeState(ApiResponse<Module>? state) {
    _module = state;
    notifyListeners();
  }

  Future<ApiResponse<Module>> getModule({required String id}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await ModuleAPI.getModule(id: id);
      changeState(ApiResponse<Module>(data: res, status: ApiStatus.success));
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
    return Future.value(_module);
  }
}
