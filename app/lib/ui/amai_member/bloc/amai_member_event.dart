import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'amai_member_event.freezed.dart';

abstract class AmaiMemberEvent extends BaseBlocEvent {
  const AmaiMemberEvent();
}

@freezed
class MemberPageInitiated extends AmaiMemberEvent with _$MemberPageInitiated {
  const factory MemberPageInitiated() = _MemberPageInitiated;
}

@freezed
class MemberPageRefreshed extends AmaiMemberEvent with _$MemberPageRefreshed {
  const factory MemberPageRefreshed({
    required Completer<void> completer,
  }) = _MemberPageRefreshed;
}

@freezed
class MemberLoadMore extends AmaiMemberEvent with _$MemberLoadMore {
  const factory MemberLoadMore() = _MemberLoadMore;
}
