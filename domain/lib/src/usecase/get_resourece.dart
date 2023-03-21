import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_resourece.freezed.dart';

@Injectable()
class GetResourceUseCase extends BaseFutureResUseCase<GetResourceInput, ResourceDataEntry> {
  GetResourceUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<ResourceDataEntry> buildUseCase(GetResourceInput input) {
    return _repository.getResource();
  }
}

@freezed
class GetResourceInput extends BaseInput with _$GetResourceInput {
  const factory GetResourceInput() = _GetResourceInput;
}
