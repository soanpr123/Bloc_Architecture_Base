import 'package:freezed_annotation/freezed_annotation.dart';

part 'reppy_coment_entry.freezed.dart';

@freezed
class ReppyComentDataEntry with _$ReppyComentDataEntry {
  const factory ReppyComentDataEntry({
    @Default(-1) int? id,
    @Default('') String? name,
    @Default('') String? avatar,
    String? content,
    @Default(0) int? isOwner,
    @Default(0) int? isLiked,
    @Default(0) int? totalLikes,
    @Default('') String replyUserName,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
    @Default(<dynamic>[]) List<dynamic>? reply,
  }) = _ReppyComentDataEntry;
}
