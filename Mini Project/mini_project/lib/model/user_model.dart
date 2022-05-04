import 'package:mini_project/model/post_comment_model.dart';
import 'package:mini_project/model/post_model.dart';

class User {
  String? sId;
  String? email;
  String? facebook;
  String? firstName;
  String? google;
  bool? isEmailVerified;
  String? lastName;
  String? phoneNumber;
  List<PostComment>? postComments;
  List<Post>? posts;
  List<String>? role;

  User(
      {this.sId,
      this.email,
      this.facebook,
      this.firstName,
      this.google,
      this.isEmailVerified,
      this.lastName,
      this.phoneNumber,
      this.postComments,
      this.posts,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    facebook = json['facebook'];
    firstName = json['firstName'];
    google = json['google'];
    isEmailVerified = json['isEmailVerified'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    if (json['postComments'] != null) {
      postComments = <PostComment>[];
      json['postComments'].forEach((v) {
        postComments!.add(PostComment.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
    role = json['role'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['facebook'] = facebook;
    data['firstName'] = firstName;
    data['google'] = google;
    data['isEmailVerified'] = isEmailVerified;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    if (postComments != null) {
      data['postComments'] = postComments!.map((v) => v.toJson()).toList();
    }
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['role'] = role;
    return data;
  }
}
