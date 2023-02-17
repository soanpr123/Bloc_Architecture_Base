part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final AppElevatedButtonState buttonState;
  const PaymentState({this.buttonState = AppElevatedButtonState.active});

  PaymentState addState({AppElevatedButtonState? buttonState}) {
    return PaymentState(buttonState: buttonState ?? this.buttonState);
  }

  @override
  List<Object> get props => [buttonState];
}
