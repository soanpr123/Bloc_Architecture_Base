import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'amai_member_state.freezed.dart';

@freezed
class AmaiMemberState extends BaseBlocState with _$AmaiMemberState {
  const factory AmaiMemberState({
    @Default(LoadMoreOutput<MemberDataEntry>(data: <MemberDataEntry>[])) LoadMoreOutput<MemberDataEntry> member,
    @Default(false) bool isShimmerLoading,
    AppException? loadUsersException,
    @Default(true) bool enablePullNotifi,
    @Default(APIRequestStatus.loading) APIRequestStatus apirequest,
    @Default(1) int page,
  }) = _AmaiMemberState;
}
