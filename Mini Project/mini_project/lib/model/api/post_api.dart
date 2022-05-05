import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/services/services.dart';

class PostAPI {
  static Future<List<Post>> getPosts() async {
    Services repo = Services();
    final response = await repo.get(url: 'Posts?\$lookup=*');
    return await Future.value(response.map<Post>((e) => Post.fromJson(e)).toList());
  }

  static Future<Post> getPost({required id}) async {
    Services repo = Services();
    final response = await repo.get(url: 'Posts/$id?\$lookup=*');
    return await Future.value(Post.fromJson(response));
  }

  static Future<PostResult> createPost({required PostInput input}) async {
    Services repo = Services();
    final response = await repo.post(url: 'Posts', data: input);
    return await Future.value(PostResult.fromJson(response));
  }
}
