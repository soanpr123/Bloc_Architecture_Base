
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'wiki_state.freezed.dart';

@freezed
class WikiState extends BaseBlocState with _$WikiState {
  const factory WikiState({
    @Default(LoadMoreOutput<DataWiki>(data: <DataWiki>[])) LoadMoreOutput<DataWiki> wiki,
    @Default(APIRequestStatus.loading) APIRequestStatus apirequestNoti,
    @Default(false) bool isShimmerLoading,
    AppException? loadUsersException,
  }) = _WikiState;
}
