import 'package:mini_project/model/user_model.dart';

class Post {
  String? sId;
  String? description;
  List<User>? user;

  Post({this.sId, this.description, this.user});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
