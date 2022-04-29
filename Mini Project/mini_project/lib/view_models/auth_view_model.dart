import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/auth_api.dart';
import 'package:mini_project/model/auth_model.dart';
import 'package:mini_project/services/local_storage.dart';
import 'package:mini_project/services/services.dart';

const tokenKey = "auth_token";

class AuthViewModel extends ChangeNotifier {
  ApiResponse<TokenResult>? _token = ApiResponse(status: ApiStatus.success);

  ApiResponse<TokenResult>? get token => _token;

  void changeTokenState(ApiResponse<TokenResult>? state) {
    _token = state;
    notifyListeners();
  }

  Future<ApiResponse<TokenResult>> register({required RegisterInput input}) async {
    try {
      changeTokenState(ApiResponse(status: ApiStatus.loading));
      final res = await AuthAPI.register(input: input);
      changeTokenState(ApiResponse<TokenResult>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeTokenState(ApiResponse(
            status: ApiStatus.error,
            message:
                (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic));
      } else {
        changeTokenState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
      }
    }
    return Future.value(_token);
  }

  Future<ApiResponse<TokenResult>> login({required LoginInput input}) async {
    try {
      changeTokenState(ApiResponse(status: ApiStatus.loading));
      final res = await AuthAPI.login(input: input);
      setToken(token: res.token!);
      changeTokenState(ApiResponse<TokenResult>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeTokenState(ApiResponse(
            status: ApiStatus.error,
            message:
                (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic));
      } else {
        changeTokenState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
      }
    }
    return Future.value(_token);
  }

  Future<void> setToken({required String token}) async {
    LocalStorage ls = LocalStorage();
    await ls.set(spKey: tokenKey, data: token);
  }

  Future<String?> setupToken() async {
    LocalStorage ls = LocalStorage();
    String? curToken = await ls.get(spKey: tokenKey);
    Services.assignToken(curToken);
    return await Future.value(curToken);
  }

  Future<void> revokeToken() async {
    LocalStorage ls = LocalStorage();
    await ls.remove(spKey: tokenKey);
    notifyListeners();
  }
}
