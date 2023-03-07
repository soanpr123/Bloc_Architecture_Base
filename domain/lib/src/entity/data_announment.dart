import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_announment.freezed.dart';

@freezed
class DataAnnoument with _$DataAnnoument {
  const factory DataAnnoument({
    @Default('') String? title,
    String? slug,
    @Default(-1) int? isRead,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
  }) = _DataAnnoument;
}
