import 'package:freezed_annotation/freezed_annotation.dart';
part 'qr_code_scan_data.freezed.dart';
part 'qr_code_scan_data.g.dart';

@freezed
class QrCodeDataData2 with _$QrCodeDataData2 {
  const factory QrCodeDataData2({
    @JsonKey(name: "amount_amais") int? amountAmais,
    @JsonKey(name: "receive_user_id") int? receiveUserId,
    @JsonKey(name: "receive_user_name") String? receiveUserName,
  }) = _QrCodeDataData2;

  factory QrCodeDataData2.fromJson(Map<String, dynamic> json) => _$QrCodeDataData2FromJson(json);
}

@freezed
class QrCodeData with _$QrCodeData {
  const factory QrCodeData({
    int? type,
    QrCodeDataData2? data,
  }) = _QrCodeData;

  factory QrCodeData.fromJson(Map<String, dynamic> json) => _$_QrCodeData.fromJson(json);
}
