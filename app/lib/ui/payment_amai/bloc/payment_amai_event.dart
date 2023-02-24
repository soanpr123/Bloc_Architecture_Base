
import 'package:freezed_annotation/freezed_annotation.dart';


import '../../../base/bloc/base_event.dart';

part 'payment_amai_event.freezed.dart';

abstract class PaymentAmaiEvent extends BaseBlocEvent {
  const PaymentAmaiEvent();
}

@freezed
class PaymentAmaiInitiated extends PaymentAmaiEvent with _$PaymentAmaiInitiated {
  const factory PaymentAmaiInitiated() = _PaymentAmaiInitiated;
}
