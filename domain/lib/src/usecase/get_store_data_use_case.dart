import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';


import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_store_data_use_case.freezed.dart';

@Injectable()
class GetStoreUseCase extends BaseFutureResUseCase<GetStoreInput, ListDataStoreEntry> {
  GetStoreUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<ListDataStoreEntry> buildUseCase(GetStoreInput input) {
    return _repository.getDataStore();
  }
}

@freezed
class GetStoreInput extends BaseInput with _$GetStoreInput {
  const factory GetStoreInput() = _GetStoreInput;
}
