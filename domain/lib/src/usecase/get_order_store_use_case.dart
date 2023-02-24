import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_order_store_use_case.freezed.dart';

@Injectable()
class GetOrderStoreUseCase extends BaseFutureResUseCase<GetOrderStoreInput, AmaiOrder> {
  GetOrderStoreUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<AmaiOrder> buildUseCase(GetOrderStoreInput input) {
    return _repository.getOrderStore();
  }
}

@freezed
class GetOrderStoreInput extends BaseInput with _$GetOrderStoreInput {
  const factory GetOrderStoreInput() = _GetOrderStoreInput;
}
