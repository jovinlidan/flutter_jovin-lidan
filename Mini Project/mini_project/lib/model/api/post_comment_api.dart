import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/services/services.dart';

class PostCommentAPI {
  static Future<List<PostComment>> getPostComments({required String postId}) async {
    Services repo = Services();
    final response = await repo.get(url: 'PostComments?\$lookup=*&post[0]=$postId');
    return await Future.value(response.map<PostComment>((e) => PostComment.fromJson(e)).toList());
  }

  static Future<PostCommentResult> createPostComment({required PostCommentInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'PostComments', data: input);
    return await Future.value(PostCommentResult.fromJson(response));
  }
}
