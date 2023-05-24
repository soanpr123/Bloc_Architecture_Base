import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

part 'save_token_fcm_usecase.freezed.dart';

@Injectable()
class SaveTokenFcmUseCase extends BaseFutureUseCase<SaveTokenFcmInput, SaveTokenFcmOutput> {
  const SaveTokenFcmUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<SaveTokenFcmOutput> buildUseCase(SaveTokenFcmInput input) async {
    await _repository.saveFcmToken(input.tokenFcm);

    return const SaveTokenFcmOutput();
  }
}

@freezed
class SaveTokenFcmInput extends BaseInput with _$SaveTokenFcmInput {
  const factory SaveTokenFcmInput({
    required String tokenFcm,
  }) = _SaveTokenFcmInput;
}

@freezed
class SaveTokenFcmOutput extends BaseOutput with _$SaveTokenFcmOutput {
  const SaveTokenFcmOutput._();

  const factory SaveTokenFcmOutput() = _SaveTokenFcmOutput;
}
