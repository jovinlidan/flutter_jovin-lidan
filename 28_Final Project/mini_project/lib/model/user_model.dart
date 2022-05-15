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
  String? pictureUrl;

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
      this.pictureUrl,
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
    pictureUrl = json['pictureUrl'];
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
    data['pictureUrl'] = pictureUrl;
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

class UpdateProfilePictureInput {
  String? pictureUrl;

  UpdateProfilePictureInput({this.pictureUrl});

  UpdateProfilePictureInput.fromJson(Map<String, dynamic> json) {
    pictureUrl = json['pictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pictureUrl'] = pictureUrl;
    return data;
  }
}

class UserResult {
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
  String? pictureUrl;

  UserResult(
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
      this.pictureUrl,
      this.role});

  UserResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    facebook = json['facebook'];
    firstName = json['firstName'];
    google = json['google'];
    isEmailVerified = json['isEmailVerified'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    pictureUrl = json['pictureUrl'];
    if (json['postComments'] != null) {
      postComments = [];
      json['postComments'].forEach((v) {
        postComments!.add(v);
      });
    }
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts!.add(v);
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
    data['pictureUrl'] = pictureUrl;
    if (postComments != null) {
      data['postComments'] = postComments!.map((v) => v).toList();
    }
    if (posts != null) {
      data['posts'] = posts!.map((v) => v).toList();
    }
    data['role'] = role;
    return data;
  }
}
