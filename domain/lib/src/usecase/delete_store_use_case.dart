import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'delete_store_use_case.freezed.dart';

@Injectable()
class DeleteOrderStoreUseCase extends BaseFutureResUseCase<DeleteOrderStoreInput, BaseEntryData> {
  DeleteOrderStoreUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(DeleteOrderStoreInput input) {
    return _repository.deleteOrderStore();
  }
}

@freezed
class DeleteOrderStoreInput extends BaseInput with _$DeleteOrderStoreInput {
  const factory DeleteOrderStoreInput() = _DeleteOrderStoreInput;
}
