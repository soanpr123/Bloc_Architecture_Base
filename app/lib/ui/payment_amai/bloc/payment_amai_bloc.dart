import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class PaymentAmaiBloc extends BaseBloc<PaymentAmaiEvent, PaymentAmaiState> {
  PaymentAmaiBloc(this._paymentUseCase) : super(const PaymentAmaiState()) {
    on<PaymentAmaiInitiated>(
      _onPaymentAmaiPageInitiated,
      transformer: log(),
    );
  }
  final PaymentUseCase _paymentUseCase;

  FutureOr<void> _onPaymentAmaiPageInitiated(PaymentAmaiInitiated event, Emitter<PaymentAmaiState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(buttonState: AppElevatedButtonState.loading));
      },
      action: () async {
        final output = await _paymentUseCase.execute(PaymentInput(amai: event.amount));
        if (output.data['status_code'] == 200) {
          emit(state.copyWith(buttonState: AppElevatedButtonState.active, status: true));
        } else {
          errorToast(msg: output.data['message'].toString());
          emit(state.copyWith(buttonState: AppElevatedButtonState.active, status: false));
        }
      },
      doOnSuccessOrError: () async {
        emit(state.copyWith(buttonState: AppElevatedButtonState.active));
      },
      doOnError: (e) async {
        errorToast(msg: exceptionMessageMapper.map(e));
      },
      handleLoading: false,
    );
  }
}
