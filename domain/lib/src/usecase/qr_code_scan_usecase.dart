import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'qr_code_scan_usecase.freezed.dart';

@Injectable()
class QrcodeScanUseCase extends BaseFutureResUseCase<QrcodeScanInput, QrcodeScanDataEntry> {
  QrcodeScanUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<QrcodeScanDataEntry> buildUseCase(QrcodeScanInput input) {
    return _repository.qrCodeScan(input.token);
  }
}

@freezed
class QrcodeScanInput extends BaseInput with _$QrcodeScanInput {
  const factory QrcodeScanInput({required String token}) = _QrcodeScanInput;
}
