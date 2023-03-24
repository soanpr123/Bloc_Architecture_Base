import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'donate_amai_use_case.freezed.dart';

@Injectable()
class DonateAmaiUseCase extends BaseFutureResUseCase<DonateAmaiInput, BaseEntryData> {
  DonateAmaiUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(DonateAmaiInput input) {
    return _repository.donateAmai(
        receiveId: input.receiveId, amountAmais: input.amountAmais, donateType: input.donateType, note: input.note);
  }
}

@freezed
class DonateAmaiInput extends BaseInput with _$DonateAmaiInput {
  const factory DonateAmaiInput({
    required int receiveId,
    required int amountAmais,
    required int donateType,
    required String note,
  }) = _GetResourceInput;
}
