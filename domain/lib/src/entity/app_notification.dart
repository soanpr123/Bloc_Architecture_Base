import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    @Default('') String id,
    @Default('') String userName,
    @Default('') String avatar,
    @Default('') dynamic others,
    @Default('') String? action,
    @Default(0) int commentId,
    @Default('') String? type,
    @Default('') String? slug,
    @Default('') String? title,
    @Default('') String? createdAt,
    @Default('') String? readAt,
  }) = _AppNotification;
}
