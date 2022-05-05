import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/post_api.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';

class PostViewModel with ChangeNotifier {
  ApiResponse<Post>? _post = ApiResponse(status: ApiStatus.success);
  ApiResponse<Post>? get post => _post;

  void changeState(ApiResponse<Post>? state) {
    _post = state;
    notifyListeners();
  }

  Future<ApiResponse<Post>> getPost({required String id}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await PostAPI.getPost(id: id);

      changeState(ApiResponse<Post>(data: res, status: ApiStatus.success));
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
    return Future.value(_post);
  }
}
