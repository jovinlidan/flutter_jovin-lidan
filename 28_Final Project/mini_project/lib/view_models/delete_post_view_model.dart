import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/post_api.dart';
import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';

class DeletePostViewModel extends ChangeNotifier {
  ApiResponse<PostResult>? _postResult = ApiResponse(status: ApiStatus.success);

  ApiResponse<PostResult>? get postResult => _postResult;

  void changeState(ApiResponse<PostResult>? state) {
    _postResult = state;
    notifyListeners();
  }

  Future<ApiResponse<PostResult>> deletePost({required String postId}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await PostAPI.deletePost(postId: postId);
      changeState(ApiResponse<PostResult>(data: res, status: ApiStatus.success));
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
    return Future.value(_postResult);
  }
}
