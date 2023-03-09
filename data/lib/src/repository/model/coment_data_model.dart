import 'package:freezed_annotation/freezed_annotation.dart';
part 'coment_data_model.freezed.dart';
part 'coment_data_model.g.dart';

@freezed
class Reply with _$Reply {
  const factory Reply({
    int? id,
    String? name,
    String? avatar,
    String? content,
    @JsonKey(name: 'is_owner') int? isOwner,
    @JsonKey(name: 'is_liked') int? isLiked,
    @JsonKey(name: 'total_likes') int? totalLikes,
    @JsonKey(name: 'reply_user_name') String? replyUserName,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<dynamic>? reply,
  }) = _Reply;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}

@freezed
class ComentDataModel with _$ComentDataModel {
  const factory ComentDataModel({
    int? id,
    String? name,
    String? avatar,
    String? content,
    @JsonKey(name: 'is_owner') int? isOwner,
    @JsonKey(name: 'is_liked') int? isLiked,
    @JsonKey(name: 'total_likes') int? totalLikes,
    @JsonKey(name: 'reply_user_name') String? replyUserName,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<Reply>? reply,
  }) = _ComentDataModel;

  factory ComentDataModel.fromJson(Map<String, dynamic> json) => _$ComentDataModelFromJson(json);
}
