part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<Notification> notification;
  final List<Notification> notificationUnread;
  final APIRequestStatus apiRequestStatus;
  final APIRequestStatus apiRequestStatusUnread;
  final int page;
  final int pageUnread;
  const NotificationState(
      {required this.notification,
      this.apiRequestStatus = APIRequestStatus.nodata,
      this.apiRequestStatusUnread = APIRequestStatus.nodata,
      required this.notificationUnread,
      this.page = 1,
      this.pageUnread = 1});
  NotificationState coppyWith(
      {List<Notification>? notification,
      List<Notification>? notificationUnread,
      APIRequestStatus? apiRequestStatus,
      APIRequestStatus? apiRequestStatusUnread,
      int? page,
      int? pageUnread}) {
    return NotificationState(
        notification: notification ?? this.notification,
        notificationUnread: notificationUnread ?? this.notificationUnread,
        apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus,
        apiRequestStatusUnread: apiRequestStatusUnread ?? this.apiRequestStatusUnread,
        page: page ?? this.page,
        pageUnread: pageUnread ?? this.pageUnread);
  }

  @override
  List<Object> get props =>
      [notification, notificationUnread, apiRequestStatus, apiRequestStatusUnread, page, pageUnread];
}
