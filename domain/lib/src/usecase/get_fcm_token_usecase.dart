import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';

part 'get_fcm_token_usecase.freezed.dart';

@Injectable()
class GetFcmTokenUseCase extends BaseFutureUseCase<GetFcmTokenDataInput, GetFcmTokenDataOutput> {
  const GetFcmTokenUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<GetFcmTokenDataOutput> buildUseCase(GetFcmTokenDataInput input) {
    return _repository.getFcmToken();
  }
}

@freezed
class GetFcmTokenDataInput extends BaseInput with _$GetFcmTokenDataInput {
  const factory GetFcmTokenDataInput() = _GetFcmTokenDataInput;
}

@freezed
class GetFcmTokenDataOutput extends BaseOutput with _$GetFcmTokenDataOutput {
  const GetFcmTokenDataOutput._();

  const factory GetFcmTokenDataOutput({
    @Default('') String token,
  }) = _GetFcmTokenDataOutput;
}
