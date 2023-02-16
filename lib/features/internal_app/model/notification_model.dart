class NotificationModel {
  int? statusCode;
  String? message;
  String? errors;
  DataNotification? data;

  NotificationModel({this.statusCode, this.message, this.errors, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? DataNotification.fromJson(json['data']) : null;
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

class DataNotification {
  List<Notification>? data;
  int? perPage;
  int? totalPage;
  int? currentPage;
  int? total;

  DataNotification({this.data, this.perPage, this.totalPage, this.currentPage, this.total});

  DataNotification.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Notification>[];
      json['data'].forEach((v) {
        data!.add(Notification.fromJson(v));
      });
    }
    perPage = json['per_page'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['data'] = data;

    data['per_page'] = perPage;
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['total'] = total;
    return data;
  }
}

class Notification {
  String? id;
  String? userName;
  String? userAvatar;
  String? others;
  String? action;
  int? commentId;
  String? type;
  String? slug;
  String? title;
  String? createdAt;
  String? readAt;

  Notification(
      {this.id,
      this.userName,
      this.userAvatar,
      this.others,
      this.action,
      this.commentId,
      this.type,
      this.slug,
      this.title,
      this.createdAt,
      this.readAt});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userAvatar = json['user_avatar'];
    others = json['others'];
    action = json['action'];
    commentId = json['comment_id'];
    type = json['type'];
    slug = json['slug'];
    title = json['title'];
    createdAt = json['created_at'];
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['user_avatar'] = userAvatar;
    data['others'] = others;
    data['action'] = action;
    data['comment_id'] = commentId;
    data['type'] = type;
    data['slug'] = slug;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['read_at'] = readAt;
    return data;
  }
}
