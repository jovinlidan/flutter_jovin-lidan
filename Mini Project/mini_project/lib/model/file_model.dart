class File {
  String? sId;
  String? bucket;
  String? fileName;
  String? key;
  String? mimeType;
  int? size;
  String? url;

  File({this.sId, this.bucket, this.fileName, this.key, this.mimeType, this.size, this.url});

  File.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bucket = json['bucket'];
    fileName = json['fileName'];
    key = json['key'];
    mimeType = json['mimeType'];
    size = json['size'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bucket'] = bucket;
    data['fileName'] = fileName;
    data['key'] = key;
    data['mimeType'] = mimeType;
    data['size'] = size;
    data['url'] = url;
    return data;
  }
}
