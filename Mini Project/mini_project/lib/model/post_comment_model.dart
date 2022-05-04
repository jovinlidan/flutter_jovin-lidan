import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/model/user_model.dart';

class PostComment {
  String? sId;
  String? description;
  List<Post>? post;
  List<User>? user;

  PostComment({this.sId, this.description, this.post, this.user});

  PostComment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    if (json['post'] != null) {
      post = <Post>[];
      json['post'].forEach((v) {
        post!.add(Post.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['description'] = description;
    if (post != null) {
      data['post'] = post!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
