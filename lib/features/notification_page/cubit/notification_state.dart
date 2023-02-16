part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<Notification> notification;
  final List<Notification> notificationUnread;
  final APIRequestStatus apiRequestStatus;
  final APIRequestStatus apiRequestStatusUnread;
  final int page;
  final int pageUnread;
  final bool onReloadNotifi;
  final bool onReloadUnread;
  final bool enablePullNotifi;
  final bool enablePullUnread;
  const NotificationState({
    required this.notification,
    this.apiRequestStatus = APIRequestStatus.loading,
    this.apiRequestStatusUnread = APIRequestStatus.loading,
    required this.notificationUnread,
    this.page = 1,
    this.pageUnread = 1,
    this.onReloadNotifi = false,
    this.onReloadUnread = false,
    this.enablePullNotifi = true,
    this.enablePullUnread = true,
  });
  NotificationState coppyWith(
      {List<Notification>? notification,
      List<Notification>? notificationUnread,
      APIRequestStatus? apiRequestStatus,
      APIRequestStatus? apiRequestStatusUnread,
      int? page,
      int? pageUnread,
      bool? onReloadNotifi,
      bool? onReloadUnread,
      bool? enablePullNotifi,
      bool? enablePullUnread}) {
    return NotificationState(
        notification: notification ?? this.notification,
        notificationUnread: notificationUnread ?? this.notificationUnread,
        apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus,
        apiRequestStatusUnread: apiRequestStatusUnread ?? this.apiRequestStatusUnread,
        page: page ?? this.page,
        pageUnread: pageUnread ?? this.pageUnread,
        onReloadNotifi: onReloadNotifi ?? this.onReloadNotifi,
        onReloadUnread: onReloadUnread ?? this.onReloadUnread,
        enablePullNotifi: enablePullNotifi ?? this.enablePullNotifi,
        enablePullUnread: enablePullUnread ?? this.enablePullUnread);
  }

  @override
  List<Object> get props => [
        notification,
        notificationUnread,
        apiRequestStatus,
        apiRequestStatusUnread,
        page,
        pageUnread,
        onReloadNotifi,
        onReloadUnread,
        enablePullNotifi,
        enablePullUnread
      ];
}
