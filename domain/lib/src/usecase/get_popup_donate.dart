import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_popup_donate.freezed.dart';

@Injectable()
class GetPopUpDonateUseCase extends BaseFutureResUseCase<GetPopUpDonateUseInput, PopUpDonateEntry> {
  GetPopUpDonateUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<PopUpDonateEntry> buildUseCase(GetPopUpDonateUseInput input) {
    return _repository.getPopUpDonate();
  }
}

@freezed
class GetPopUpDonateUseInput extends BaseInput with _$GetPopUpDonateUseInput {
  const factory GetPopUpDonateUseInput() = _GetPopUpDonateUseInput;
}
