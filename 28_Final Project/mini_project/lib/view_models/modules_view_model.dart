import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/module_api.dart';
import 'package:mini_project/model/module_model.dart';
import 'package:mini_project/services/services.dart';

class ModulesViewModel with ChangeNotifier {
  ApiResponse<List<Module>>? _modules = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<Module>>? get modules => _modules;

  void changeState(ApiResponse<List<Module>>? state) {
    _modules = state;
    notifyListeners();
  }

  Future<ApiResponse<List<Module>>> getModules() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await ModuleAPI.getModules();

      changeState(ApiResponse<List<Module>>(data: res, status: ApiStatus.success));
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
    return Future.value(_modules);
  }
}
