import 'package:freezed_annotation/freezed_annotation.dart';

part 'amai_model_detail_wiki.freezed.dart';

@freezed
class WikiDetail with _$WikiDetail {
  const factory WikiDetail({
    @Default('') String? title,
    @Default('') String? slug,
    @Default('') String? content,
    @Default('') String? thumb,
    @Default('') String? url,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
    @Default('') String? publishedAt,
  }) = _WikiDetail;
}
