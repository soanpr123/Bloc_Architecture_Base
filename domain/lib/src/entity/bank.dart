import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank.freezed.dart';

@freezed
class Bank with _$Bank {
  const factory Bank({
    @Default('') String? accountNumber,
    @Default('') String? bank,
    @Default('') String? bankAgency,
    @Default('') String? name,
    @Default('') String? shortName,
  }) = _Bank;
}
