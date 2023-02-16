class AnnouncementModel {
  int? statusCode;
  String? message;
  String? errors;
  DataAnnouncementModel? data;

  AnnouncementModel({this.statusCode, this.message, this.errors, this.data});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? DataAnnouncementModel.fromJson(json['data']) : null;
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

class DataAnnouncementModel {
  List<AnnouncementData>? data;
  int? perPage;
  int? totalPage;
  int? currentPage;
  int? total;

  DataAnnouncementModel({this.data, this.perPage, this.totalPage, this.currentPage, this.total});

  DataAnnouncementModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AnnouncementData>[];
      json['data'].forEach((v) {
        data!.add(AnnouncementData.fromJson(v));
      });
    }
    perPage = json['per_page'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = perPage;
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['total'] = total;
    return data;
  }
}

class AnnouncementData {
  String? title;
  String? slug;
  int? isRead;
  String? createdAt;
  String? updatedAt;

  AnnouncementData({this.title, this.slug, this.isRead, this.createdAt, this.updatedAt});

  AnnouncementData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['slug'] = slug;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
