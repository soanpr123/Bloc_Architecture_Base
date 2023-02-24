import 'package:freezed_annotation/freezed_annotation.dart';
part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
class Data2Notification with _$Data2Notification {
  const factory Data2Notification({
    String? id,
    @JsonKey(name: 'user_name') dynamic userName,
    @JsonKey(name: 'user_avatar') dynamic userAvatar,
    dynamic others,
    String? action,
    @JsonKey(name: 'comment_id') dynamic commentId,
    String? type,
    String? slug,
    String? title,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'read_at') String? readAt,
  }) = _Data2Notification;

  factory Data2Notification.fromJson(Map<String, dynamic> json) => _$Data2NotificationFromJson(json);
}

@freezed
class NotificationData with _$NotificationData {
  const factory NotificationData({
    List<Data2Notification>? data,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_page') int? totalPage,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);
}

