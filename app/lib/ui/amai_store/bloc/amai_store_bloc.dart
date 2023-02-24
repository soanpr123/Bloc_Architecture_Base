import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class AmaiStoreBloc extends BaseBloc<AmaiStoreEvent, AmaiStoreState> {
  AmaiStoreBloc(
    this._getStoreUseCase,
    this._deleteOrderStoreUseCase,
    this._getOrderStoreUseCase,
    this._orderStoreUseCase,
  ) : super(const AmaiStoreState()) {
    on<AmaiStoreInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );

    on<AmaiStoreOrderPress>(
      _onAmaiStoreOrderPress,
      transformer: log(),
    );

    on<AmaiStoreDeleteOrderPress>(
      _onAmaiDeleteOrderPress,
      transformer: log(),
    );
    on<AmaiStoreGetOrder>(
      _onAmaiGetOrderPress,
      transformer: log(),
    );
  }

  final GetStoreUseCase _getStoreUseCase;
  final DeleteOrderStoreUseCase _deleteOrderStoreUseCase;
  final GetOrderStoreUseCase _getOrderStoreUseCase;
  final OrderStoreUseCase _orderStoreUseCase;
  FutureOr<void> _onMainPageInitiated(AmaiStoreInitiated event, Emitter<AmaiStoreState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      action: () async {
        final output = await _getStoreUseCase.execute(const GetStoreInput());

        emit(state.copyWith(canteen: output.canteen, other: output.other));
      },
      doOnSuccessOrError: () async => emit(
        state.copyWith(isShimmerLoading: false),
      ),
      handleLoading: false,
    );

    await _getOrder(emit);
  }

  FutureOr<void> _onAmaiStoreOrderPress(AmaiStoreOrderPress event, Emitter<AmaiStoreState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(buttonStateOrder: AppElevatedButtonState.loading)),
      action: () async {
        final output = await _orderStoreUseCase.execute(OrderStoreInput(id: event.id.toString()));

        if (output.data['status_code'] == 200) {
          successToast(output.data['message'].toString());
          await _getOrder(emit);
        } else {
          errorToast(msg: output.data['message'].toString());
        }
      },
      doOnSuccessOrError: () async => emit(
        state.copyWith(buttonStateOrder: AppElevatedButtonState.active),
      ),
      handleLoading: true,
    );
  }

  FutureOr<void> _onAmaiDeleteOrderPress(AmaiStoreDeleteOrderPress event, Emitter<AmaiStoreState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(buttonStateDelete: AppElevatedButtonState.loading)),
      action: () async {
        final output = await _deleteOrderStoreUseCase.execute(const DeleteOrderStoreInput());

        if (output.data['status_code'] == 200) {
          successToast(output.data['message'].toString());
        } else {
          errorToast(msg: output.data['message'].toString());
        }
        await _getOrder(emit);
      },
      doOnSuccessOrError: () async => emit(
        state.copyWith(buttonStateDelete: AppElevatedButtonState.active),
      ),
      handleLoading: false,
    );
  }

  FutureOr<void> _onAmaiGetOrderPress(AmaiStoreGetOrder event, Emitter<AmaiStoreState> emit) async {
    await _getOrder(emit);
  }

  Future<void> _getOrder(Emitter<AmaiStoreState> emit) async {
    return await runBlocCatching(
      action: () async {
        final output = await _getOrderStoreUseCase.execute(const GetOrderStoreInput());
        // print(output.id);
        if (output.id != -1) {
          emit(state.copyWith(amaiOrder: output));
        } else {
          emit(state.copyWith(amaiOrder: const AmaiOrder(id: -1)));
        }
      },
      doOnSuccessOrError: () async => emit(
        state.copyWith(buttonStateDelete: AppElevatedButtonState.active),
      ),
      handleLoading: false,
    );
  }
}
