import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/post_api.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';

class PostsViewModel with ChangeNotifier {
  ApiResponse<List<Post>>? _posts = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<Post>>? get posts => _posts;

  void changeState(ApiResponse<List<Post>>? state) {
    _posts = state;
    notifyListeners();
  }

  Future<ApiResponse<List<Post>>> getPosts() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await PostAPI.getPosts();
      changeState(ApiResponse<List<Post>>(data: res, status: ApiStatus.success));
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
    return Future.value(_posts);
  }
}
