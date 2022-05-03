class Course {
  String? sId;
  DateTime? createdAt;
  String? description;
  String? duration;
  String? imageUrl;
  String? title;
  String? videoUrl;

  Course(
      {this.sId,
      this.createdAt,
      this.description,
      this.duration,
      this.imageUrl,
      this.title,
      this.videoUrl});

  Course.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = DateTime.parse(json['createdAt']);
    description = json['description'];
    duration = json['duration'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['duration'] = duration;
    data['imageUrl'] = imageUrl;
    data['title'] = title;
    data['videoUrl'] = videoUrl;
    return data;
  }
}
