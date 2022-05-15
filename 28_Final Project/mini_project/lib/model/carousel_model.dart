class Carousel {
  String? sId;
  String? image;
  String? url;

  Carousel({this.sId, this.image, this.url});

  Carousel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}
