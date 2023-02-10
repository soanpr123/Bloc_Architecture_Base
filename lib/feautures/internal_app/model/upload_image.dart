class UploadImage {
  int? statusCode;
  String? message;
  String? errors;
  DataUpload? data;

  UploadImage({this.statusCode, this.message, this.errors, this.data});

  UploadImage.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? DataUpload.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    data['errors'] = errors;
    data['data'] = data;
    return data;
  }
}

class DataUpload {
  String? url;
  String? thumb;
  String? type;

  DataUpload({this.url, this.thumb, this.type});
  DataUpload.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumb = json['thumb'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['thumb'] = thumb;
    data['type'] = type;
    return data;
  }
}
