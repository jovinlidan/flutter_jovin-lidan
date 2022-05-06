import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/post_comment_api.dart';
import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/services/services.dart';

class CreatePostCommentViewModel extends ChangeNotifier {
  ApiResponse<PostCommentResult>? _commentResult = ApiResponse(status: ApiStatus.success);

  ApiResponse<PostCommentResult>? get commentResult => _commentResult;

  void changeState(ApiResponse<PostCommentResult>? state) {
    _commentResult = state;
    notifyListeners();
  }

  Future<ApiResponse<PostCommentResult>> createPostComment(
      {required PostCommentInput input}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await PostCommentAPI.createPostComment(input: input);
      changeState(ApiResponse<PostCommentResult>(data: res, status: ApiStatus.success));
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
    return Future.value(_commentResult);
  }
}
