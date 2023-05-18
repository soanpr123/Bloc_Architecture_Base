import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';
import 'base/future/base_future_use_case_response.dart';


part 'get_me_use_case.freezed.dart';

@Injectable()
class GetMeUseCase extends BaseFutureResUseCase<GetMeInput, Profile> {
  GetMeUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<Profile> buildUseCase(GetMeInput input) {
    return _repository.getMe();
  }
}

@freezed
class GetMeInput extends BaseInput with _$GetMeInput {
  const factory GetMeInput() = _GetMeInput;
}
