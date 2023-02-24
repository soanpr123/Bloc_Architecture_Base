import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'update_me_use_case.freezed.dart';

@Injectable()
class UpdateMeUseCase extends BaseFutureResUseCase<UpdateMeInput, BaseEntryData> {
  const UpdateMeUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(UpdateMeInput input) async {
    final output = await _repository.updateMe(input.avt, input.about);

    return output;
  }
}

@freezed
class UpdateMeInput extends BaseInput with _$UpdateMeInput {
  const factory UpdateMeInput({
    required String avt,
    required String about,
  }) = _UpdateMeInput;
}
