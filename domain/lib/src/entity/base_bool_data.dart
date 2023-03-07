import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_bool_data.freezed.dart';

@freezed
class BaseBoolData with _$BaseBoolData {
  const factory BaseBoolData({
    @Default(false) bool data,
  }) = _BaseBoolData;
}
