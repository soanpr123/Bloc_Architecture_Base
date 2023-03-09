import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'wiki_detail_state.freezed.dart';

@freezed
class WikiDetailState extends BaseBlocState with _$WikiDetailState {
  const factory WikiDetailState({
    @Default(WikiDetail()) WikiDetail announcementDetail,
    @Default(false) bool show,
    @Default(APIRequestStatus.loading) APIRequestStatus apiRequestStatus,
  }) = _WikiDetailState;
}
