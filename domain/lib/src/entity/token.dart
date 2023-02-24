import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';

@freezed
class Token  with _$Token {
  const factory Token({
    @Default('') String accessToken,
    @Default('') String typeToken,
    @Default('') String message,
    @Default(200) int statusCode,
  }) = _Token;
}
