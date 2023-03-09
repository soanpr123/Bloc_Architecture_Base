import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'send_amai_blogs_use_case.freezed.dart';

@Injectable()
class SendAmaiUseCase extends BaseFutureResUseCase<SendAmaiInput, BaseEntryData> {
  SendAmaiUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(SendAmaiInput input) {
    return _repository.sendAmai(slungs: input.slungs);
  }
}

@freezed
class SendAmaiInput extends BaseInput with _$SendAmaiInput {
  const factory SendAmaiInput({
    required String slungs,
  }) = _SendAmaiInput;
}
