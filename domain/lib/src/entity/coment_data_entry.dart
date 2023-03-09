import 'package:domain/src/entity/reppy_coment_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coment_data_entry.freezed.dart';

@freezed
class ComentDataEntry with _$ComentDataEntry {
  const factory ComentDataEntry({
    @Default(-1) int? id,
    @Default('') String? name,
    @Default('') String? avatar,
    @Default('') String? content,
    @Default(0) int? isOwner,
    @Default(0) int? isLiked,
    @Default(0) int? totalLikes,
    @Default('') String replyUserName,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
    @Default(<ReppyComentDataEntry>[]) List<ReppyComentDataEntry>? reply,
  }) = _ComentDataEntry;
}
