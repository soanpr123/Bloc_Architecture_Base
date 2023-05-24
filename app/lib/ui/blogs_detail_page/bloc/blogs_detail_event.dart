import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
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

@freezed
class CreateComment extends BlogsDetailEvent with _$CreateComment {
  const factory CreateComment({
    @Default('') String slungs,
    @Default('') String comment,
    required ScrollController scrollController,
    required TextEditingController textEdt,
  }) = _CreateComment;
}

@freezed
class SelectComent extends BlogsDetailEvent with _$SelectComent {
  const factory SelectComent({
    @Default(-1) int id,
    @Default('') String name,
  }) = _SelectComent;
}

@freezed
class DeleteSelectCmt extends BlogsDetailEvent with _$DeleteSelectCmt {
  const factory DeleteSelectCmt() = _DeleteSelectCmt;
}

@freezed
class RepplyComment extends BlogsDetailEvent with _$RepplyComment {
  const factory RepplyComment({
    @Default('') String slungs,
    @Default('') String id,
    @Default('') String content,
    required TextEditingController textEdt,
  }) = _RepplyComment;
}

@freezed
class ForcusComment extends BlogsDetailEvent with _$ForcusComment {
  const factory ForcusComment({
    @Default(false) bool isComment,
  }) = _ForcusComment;
}

@freezed
class OnChangeCmt extends BlogsDetailEvent with _$OnChangeCmt {
  const factory OnChangeCmt({
    @Default('') String cmt,
  }) = _OnChangeCmt;
}
