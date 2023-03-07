import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'announment_state.freezed.dart';

@freezed
class AnnounmentState extends BaseBlocState with _$AnnounmentState {
  const factory AnnounmentState({
    @Default(LoadMoreOutput<DataAnnoument>(data: <DataAnnoument>[])) LoadMoreOutput<DataAnnoument> notifi,
    @Default(APIRequestStatus.loading) APIRequestStatus apirequestNoti,
    @Default(false) bool isShimmerLoading,
    AppException? loadUsersException,
  }) = _AnnounmentState;
}
