
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'blogs_detail_event.freezed.dart';

abstract class BlogsDetailEvent extends BaseBlocEvent {
  const BlogsDetailEvent();
}

@freezed
class BlogsDetailPageInitiated extends BlogsDetailEvent with _$BlogsDetailPageInitiated {
  const factory BlogsDetailPageInitiated({
    required String slungs,
  }) = _BlogsDetailPageInitiated;
}

@freezed
class BlogsPageShowBack extends BlogsDetailEvent with _$BlogsPageShowBack {
  const factory BlogsPageShowBack({
    @Default(false) bool show,
  }) = _BlogsPageShowBack;
}

@freezed
class Hidebotom extends BlogsDetailEvent with _$Hidebotom {
  const factory Hidebotom({
    @Default(0.0) double bottom,
    @Default(0.0) double offset,
     @Default(0.0) double padding,
  }) = _Hidebotom;
}

@freezed
class GetComment extends BlogsDetailEvent with _$GetComment {
  const factory GetComment({
    @Default(0.0) double bottom,
    @Default(0.0) double offset,
    @Default(0.0) double padding,
  }) = _GetComment;
}
@freezed
class LikeComment extends BlogsDetailEvent with _$LikeComment {
  const factory LikeComment({
    @Default('') String slungs,
    @Default(0) int id,
   
  }) = _LikeComment;
}
@freezed
class LikeBlogs extends BlogsDetailEvent with _$LikeBlogs {
  const factory LikeBlogs({
    @Default('') String slungs,
   
  }) = _LikeBlogs;
}

@freezed
class SendAmai extends BlogsDetailEvent with _$SendAmai {
  const factory SendAmai({
    @Default('') String slungs,
  }) = _SendAmai;
}
