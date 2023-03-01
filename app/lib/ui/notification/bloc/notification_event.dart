import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'notification_event.freezed.dart';

abstract class NotificationEvent extends BaseBlocEvent {
  const NotificationEvent();
}

@freezed
class NotificationPageInitiated extends NotificationEvent with _$NotificationPageInitiated {
  const factory NotificationPageInitiated() = _NotificationPageInitiated;
}

@freezed
class ReadNotification extends NotificationEvent with _$ReadNotification {
  const factory ReadNotification({
    required String type,
    required String slung,
    required String id,
  }) = _ReadNotification;
}

@freezed
class NotificationPageRefreshed extends NotificationEvent with _$NotificationPageRefreshed {
  const factory NotificationPageRefreshed({
    required Completer<void> completer,
  }) = _NotificationPageRefreshed;
}

@freezed
class NotificationLoadMore extends NotificationEvent with _$NotificationLoadMore {
  const factory NotificationLoadMore() = _NotificationLoadMore;
}

@freezed
class NotificationUnreadPageRefreshed extends NotificationEvent with _$NotificationUnreadPageRefreshed {
  const factory NotificationUnreadPageRefreshed({
    required Completer<void> completer,
  }) = _NotificationUnreadPageRefreshed;
}

@freezed
class NotificationUnreadLoadMore extends NotificationEvent with _$NotificationUnreadLoadMore {
  const factory NotificationUnreadLoadMore() = _NotificationUnreadLoadMore;
}

@freezed
class NotificationonTapTab extends NotificationEvent with _$NotificationonTapTab {
  const factory NotificationonTapTab({
    required TabController tabController,
  }) = _NotificationonTapTab;
}

@freezed
class ReadAllNotifiPress extends NotificationEvent with _$ReadAllNotifiPress {
  const factory ReadAllNotifiPress() = _ReadAllNotifiPress;
}
