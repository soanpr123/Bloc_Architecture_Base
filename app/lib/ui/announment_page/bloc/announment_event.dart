import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'announment_event.freezed.dart';

abstract class AnnounmentEvent extends BaseBlocEvent {
  const AnnounmentEvent();
}

@freezed
class AnnounmentPageInitiated extends AnnounmentEvent with _$AnnounmentPageInitiated {
  const factory AnnounmentPageInitiated() = _AnnounmentPageInitiated;
}

@freezed
class ReadAnnounment extends AnnounmentEvent with _$ReadAnnounment {
  const factory ReadAnnounment({
    required String slung,
  }) = _ReadAnnounment;
}

@freezed
class AnnounmentPageRefreshed extends AnnounmentEvent with _$AnnounmentPageRefreshed {
  const factory AnnounmentPageRefreshed({
    required Completer<void> completer,
  }) = _AnnounmentPageRefreshed;
}

@freezed
class AnnounmentLoadMore extends AnnounmentEvent with _$AnnounmentLoadMore {
  const factory AnnounmentLoadMore() = _AnnounmentLoadMore;
}
