import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'list_data_notification.freezed.dart';

@freezed
class ListNotification with _$ListNotification {
  const factory ListNotification({
    @Default(<AppNotification>[]) List<AppNotification> notification,
    @Default(-1) int perPage,
    @Default(-1) int totalPage,
    @Default(-1) int currentPage,
    @Default(-1) int? total,
  }) = _ListNotification;
}
