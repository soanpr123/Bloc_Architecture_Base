import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState extends BaseBlocState with _$NotificationState {
  factory NotificationState({
    @Default(LoadMoreOutput<AppNotification>(data: <AppNotification>[])) LoadMoreOutput<AppNotification> notifi,
    @Default(LoadMoreOutput<AppNotification>(data: <AppNotification>[])) LoadMoreOutput<AppNotification> notifiUnread,
    @Default(false) bool isShimmerLoading,
    @Default(true) bool enablePullNotifi,
    @Default(1) int page,
    AppException? loadUsersException,
    @Default(false) bool isShimmerLoadingUnread,
    AppException? loadNotifiUnreadException,
  }) = _NotificationState;
}
