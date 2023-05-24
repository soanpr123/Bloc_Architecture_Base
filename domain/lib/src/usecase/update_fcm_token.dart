import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'update_fcm_token.freezed.dart';

@Injectable()
class UpdateFcmTokenUseCase extends BaseFutureResUseCase<UpdateFcmTokenInput, BaseEntryData> {
  const UpdateFcmTokenUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(UpdateFcmTokenInput input) async {
    final output = await _repository.updateFcmToken(
      input.fcmToken,
      input.deviceType,
    );

    return output;
  }
}

@freezed
class UpdateFcmTokenInput extends BaseInput with _$UpdateFcmTokenInput {
  const factory UpdateFcmTokenInput({required String fcmToken, required String deviceType}) = _UpdateFcmTokenInput;
}
