import 'package:freezed_annotation/freezed_annotation.dart';

part 'education.freezed.dart';

@freezed
class Educate with _$Educate {
  const factory Educate({
    @Default('') String? gradedName,
    @Default(0) int? graded,
    @Default('') String? gpa,
    @Default('') String? gpaFormat,
    @Default('') String? universityCode,
    @Default('') String? universityName,
  }) = _Educate;
}
