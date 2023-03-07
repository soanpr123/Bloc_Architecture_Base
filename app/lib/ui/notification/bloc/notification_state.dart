import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState extends BaseBlocState with _$NotificationState {
  factory NotificationState({
    @Default(LoadMoreOutput<AppNotification>(data: <AppNotification>[])) LoadMoreOutput<AppNotification> notifi,
    @Default(LoadMoreOutput<AppNotification>(data: <AppNotification>[])) LoadMoreOutput<AppNotification> notifiUnread,
    @Default(APIRequestStatus.loading) APIRequestStatus apirequestNoti,
    @Default(APIRequestStatus.loading) APIRequestStatus apirequestUnread,
    @Default(false) bool isShimmerLoading,
    @Default(true) bool enablePullNotifi,
    @Default(0) int curentTab,
    @Default(1) int page,
    @Default(false) bool reload,
    AppException? loadUsersException,
    @Default(false) bool isShimmerLoadingUnread,
    AppException? loadNotifiUnreadException,
  }) = _NotificationState;
}
