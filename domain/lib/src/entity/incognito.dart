import 'package:freezed_annotation/freezed_annotation.dart';

part 'incognito.freezed.dart';

@freezed
class Incognito with _$Incognito {
  const factory Incognito({
    @Default(0) int? id,
    @Default('') String? name,
    @Default('') String? avatar,
    @Default('') String? about,
  }) = _Incognito;
}
