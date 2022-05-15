class Content {
  String? sId;
  String? duration;
  String? title;
  String? videoUrl;

  Content({this.sId, this.duration, this.title, this.videoUrl});

  Content.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    duration = json['duration'];
    title = json['title'];
    videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['duration'] = duration;
    data['title'] = title;
    data['videoUrl'] = videoUrl;
    return data;
  }
}
