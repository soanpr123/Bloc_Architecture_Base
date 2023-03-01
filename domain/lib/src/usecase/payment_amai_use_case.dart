import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'payment_amai_use_case.freezed.dart';

@Injectable()
class PaymentUseCase extends BaseFutureResUseCase<PaymentInput, BaseEntryData> {
  PaymentUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(PaymentInput input) {
    return _repository.paymentAmai(input.amai, input.note);
  }
}

@freezed
class PaymentInput extends BaseInput with _$PaymentInput {
  const factory PaymentInput({
    @Default(0) int amai,
    @Default(SymbolConstants.amaiNote) String note,
  }) = _PaymentInput;
}
