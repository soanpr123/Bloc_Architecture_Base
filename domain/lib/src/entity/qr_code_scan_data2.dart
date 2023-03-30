import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_code_scan_data2.freezed.dart';

@freezed
class QrcodeScanData2Entry with _$QrcodeScanData2Entry {
  const factory QrcodeScanData2Entry({
    @Default(0) int amountAmais,
    @Default(-1) int? receiveUserId,
   @Default('') String? receiveUserName,
  }) = _QrcodeScanData2Entry;
}
