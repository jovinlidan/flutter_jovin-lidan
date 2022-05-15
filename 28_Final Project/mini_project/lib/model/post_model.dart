import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/model/user_model.dart';

class Post {
  String? sId;
  List<PostComment>? comments;
  DateTime? createdAt;
  String? description;
  List<User>? user;

  Post({this.sId, this.comments, this.createdAt, this.description, this.user});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['comments'] != null) {
      comments = <PostComment>[];
      json['comments'].forEach((v) {
        comments!.add(PostComment.fromJson(v));
      });
    }
    createdAt = DateTime.parse(json['createdAt']);
    description = json['description'];
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
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostInput {
  String? description;
  List<String>? user;

  PostInput({this.description, this.user});

  PostInput.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['user'] != null) {
      user = <String>[];
      json['user'].forEach((v) {
        user!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['description'] = description;
    if (user != null) {
      data['user'] = user!.map((v) => v).toList();
    }
    return data;
  }
}

class PostResult {
  String? sId;
  List<String>? comments;
  DateTime? createdAt;
  String? description;
  List<String>? user;

  PostResult({this.sId, this.comments, this.createdAt, this.description, this.user});

  PostResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['comments'] != null) {
      comments = <String>[];
      json['comments'].forEach((v) {
        comments!.add((v));
      });
    }
    createdAt = DateTime.parse(json['createdAt']);
    description = json['description'];
    if (json['user'] != null) {
      user = <String>[];
      json['user'].forEach((v) {
        user!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v).toList();
    }
    data['createdAt'] = createdAt;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.map((v) => v).toList();
    }
    return data;
  }
}
