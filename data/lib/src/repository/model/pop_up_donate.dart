import 'package:freezed_annotation/freezed_annotation.dart';
part 'pop_up_donate.freezed.dart';
part 'pop_up_donate.g.dart';

@freezed
class PopUpDonateData with _$PopUpDonateData {
  const factory PopUpDonateData({
    String? donor,
    @JsonKey(name: 'amount_amais') int? amountAmais,
    String? note,
  }) = _PopUpDonateData;

  factory PopUpDonateData.fromJson(Map<String, dynamic> json) => _$PopUpDonateDataFromJson(json);
}
