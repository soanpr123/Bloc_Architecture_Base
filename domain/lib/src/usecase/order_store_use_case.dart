import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'order_store_use_case.freezed.dart';

@Injectable()
class OrderStoreUseCase extends BaseFutureResUseCase<OrderStoreInput, BaseEntryData> {
  OrderStoreUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(OrderStoreInput input) {
    return _repository.orderStore(input.id);
  }
}

@freezed
class OrderStoreInput extends BaseInput with _$OrderStoreInput {
  const factory OrderStoreInput({required String id}) = _OrderStoreInput;
}
