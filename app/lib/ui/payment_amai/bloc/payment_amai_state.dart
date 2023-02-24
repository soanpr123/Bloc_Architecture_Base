
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';
import '../../../base/bloc/base_state.dart';

part 'payment_amai_state.freezed.dart';

@freezed
class PaymentAmaiState extends BaseBlocState with _$PaymentAmaiState {
  const factory PaymentAmaiState({
    @Default(false) bool status,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState buttonState,
  }) = _PaymentAmaiState;
}
