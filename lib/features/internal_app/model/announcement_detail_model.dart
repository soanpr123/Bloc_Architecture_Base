class AnnouncementDetail {
  int? statusCode;
  String? message;
  String? errors;
  DataDetail? data;

  AnnouncementDetail({this.statusCode, this.message, this.errors, this.data});

  AnnouncementDetail.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? DataDetail.fromJson(json['data']) : null;
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

class DataDetail {
  String? title;
  String? slug;
  String? content;
  String? thumb;
  String? url;
  String? createdAt;
  String? updatedAt;

  DataDetail({this.title, this.slug, this.content, this.thumb, this.url, this.createdAt, this.updatedAt});

  DataDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    thumb = json['thumb'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['slug'] = slug;
    data['content'] = content;
    data['thumb'] = thumb;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
