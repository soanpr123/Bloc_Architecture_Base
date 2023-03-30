import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'qr_code_data_entry.freezed.dart';

@freezed
class QrcodeScanDataEntry with _$QrcodeScanDataEntry {
  const factory QrcodeScanDataEntry({
    @Default(-1) int type,
    @Default(QrcodeScanData2Entry()) QrcodeScanData2Entry data,
  }) = _QrcodeScanDataEntry;
}
