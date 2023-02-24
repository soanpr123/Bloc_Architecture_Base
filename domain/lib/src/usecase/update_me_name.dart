import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'update_me_name.freezed.dart';

@Injectable()
class UpdateMeNameUseCase extends BaseFutureResUseCase<UpdateMeNameInput, BaseEntryData> {
  const UpdateMeNameUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(UpdateMeNameInput input) async {
    final output = await _repository.updateMeName(
      input.name,
    );

    return output;
  }
}

@freezed
class UpdateMeNameInput extends BaseInput with _$UpdateMeNameInput {
  const factory UpdateMeNameInput({
    required String name,
  }) = _UpdateMeNameInput;
}
