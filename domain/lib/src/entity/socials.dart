import 'package:freezed_annotation/freezed_annotation.dart';

part 'socials.freezed.dart';

@freezed
class Socials with _$Socials {
  const factory Socials({
    @Default('') String? facebookUrl,
    @Default('') String? facebookUsername,
    @Default('') String? telegramUrl,
    @Default('') String? telegramUsername,
  }) = _Socials;
}
