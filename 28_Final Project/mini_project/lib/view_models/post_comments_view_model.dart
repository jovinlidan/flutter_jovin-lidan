import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/post_comment_api.dart';
import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/services/services.dart';

class PostCommentsViewModel with ChangeNotifier {
  ApiResponse<List<PostComment>>? _postComments = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<PostComment>>? get postComments => _postComments;

  void changeState(ApiResponse<List<PostComment>>? state) {
    _postComments = state;
    notifyListeners();
  }

  Future<ApiResponse<List<PostComment>>> getPostComments({required String postId}) async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await PostCommentAPI.getPostComments(postId: postId);

      changeState(ApiResponse<List<PostComment>>(data: res, status: ApiStatus.success));
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
    return Future.value(_postComments);
  }
}
