import 'package:mini_project/model/post_model.dart';
import 'package:mini_project/model/user_model.dart';

class PostComment {
  String? sId;
  String? description;
  List<Post>? post;
  List<User>? user;
  DateTime? createdAt;

  PostComment({this.sId, this.description, this.post, this.user});

  PostComment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    createdAt = DateTime.parse(json['createdAt']);

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
    data['createdAt'] = createdAt;
    if (post != null) {
      data['post'] = post!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostCommentInput {
  String? description;
  List<String>? post;
  List<String>? user;

  PostCommentInput({this.description, this.post, this.user});

  PostCommentInput.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['post'] != null) {
      post = <String>[];
      json['post'].forEach((v) {
        post!.add((v));
      });
    }
    if (json['user'] != null) {
      user = <String>[];
      json['user'].forEach((v) {
        user!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;

    if (post != null) {
      data['post'] = post!.map((v) => v).toList();
    }
    if (user != null) {
      data['user'] = user!.map((v) => v).toList();
    }
    return data;
  }
}

class PostCommentResult {
  String? description;
  List<String>? post;
  List<String>? user;
  DateTime? createdAt;

  PostCommentResult({this.description, this.post, this.user});

  PostCommentResult.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    createdAt = DateTime.parse(json['createdAt']);

    if (json['post'] != null) {
      post = <String>[];
      json['post'].forEach((v) {
        post!.add((v));
      });
    }
    if (json['user'] != null) {
      user = <String>[];
      json['user'].forEach((v) {
        user!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['createdAt'] = createdAt;

    if (post != null) {
      data['post'] = post!.map((v) => v).toList();
    }
    if (user != null) {
      data['user'] = user!.map((v) => v).toList();
    }
    return data;
  }
}
