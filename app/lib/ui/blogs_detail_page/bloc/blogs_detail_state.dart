import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';
import '../../../base/bloc/base_state.dart';

part 'blogs_detail_state.freezed.dart';

@freezed
class BlogsDetailState extends BaseBlocState with _$BlogsDetailState {
  const factory BlogsDetailState({
    @Default(BlogsDetailEntry()) BlogsDetailEntry users,
    @Default(<ComentDataEntry>[]) List<ComentDataEntry> comment,
    @Default(APIRequestStatus.loading) APIRequestStatus apiRequestStatus,
    @Default(APIRequestStatus.loaded) APIRequestStatus likeStatus,
    @Default(APIRequestStatus.loaded) APIRequestStatus sendAmaiStatus,
    @Default(AppElevatedButtonState.inactive) AppElevatedButtonState buttonSendState,
    @Default(-1) int cmtSelect,
    @Default('') String name,
    @Default(0) int isLiked,
    @Default(0) int isAmaiVotes,
    @Default(0) int totalLikes,
    @Default(0) int totalAmaiVotes,
    @Default(false) bool show,
    @Default(false) bool isComment,
    @Default(0.0) double bottom,
    @Default(0.0) double padding,
  }) = _BlogsDetailState;
}
