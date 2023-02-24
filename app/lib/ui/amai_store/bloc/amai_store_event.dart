import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'amai_store_event.freezed.dart';

abstract class AmaiStoreEvent extends BaseBlocEvent {
  const AmaiStoreEvent();
}

@freezed
class AmaiStoreInitiated extends AmaiStoreEvent with _$AmaiStoreInitiated {
  const factory AmaiStoreInitiated() = _AmaiStoreInitiated;
}

@freezed
class AmaiStoreOrderPress extends AmaiStoreEvent with _$AmaiStoreOrderPress {
  const factory AmaiStoreOrderPress({
    required int id,
  }) = _AmaiStoreOrderPress;
}

@freezed
class AmaiStoreDeleteOrderPress extends AmaiStoreEvent with _$AmaiStoreDeleteOrderPress {
  const factory AmaiStoreDeleteOrderPress() = _AmaiStoreDeleteOrderPress;
}

@freezed
class AmaiStoreGetOrder extends AmaiStoreEvent with _$AmaiStoreGetOrder {
  const factory AmaiStoreGetOrder() = _AmaiStoreGetOrder;
}
