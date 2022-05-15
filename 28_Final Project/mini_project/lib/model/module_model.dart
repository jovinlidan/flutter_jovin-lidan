import 'package:mini_project/model/content_model.dart';

class Module {
  String? sId;
  List<Content>? contents;
  DateTime? createdAt;
  String? description;
  String? duration;
  String? imageUrl;
  String? title;

  Module(
      {this.sId,
      this.contents,
      this.createdAt,
      this.description,
      this.duration,
      this.imageUrl,
      this.title});

  Module.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['contents'] != null) {
      contents = <Content>[];
      json['contents'].forEach((v) {
        contents!.add(Content.fromJson(v));
      });
    }
    createdAt = DateTime.parse(json['createdAt']);
    description = json['description'];
    duration = json['duration'];
    imageUrl = json['imageUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['duration'] = duration;
    data['imageUrl'] = imageUrl;
    data['title'] = title;
    return data;
  }
}
