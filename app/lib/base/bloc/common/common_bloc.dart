import 'dart:async';

import 'package:domain/domain.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
@LazySingleton()
class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc(
    this._clearCurrentUserDataUseCase,
    this._saveTokenFcmUseCase,
  ) : super(const CommonState()) {
    on<LoadingVisibilityEmitted>(
      _onLoadingVisibilityEmitted,
      transformer: log(),
    );

    on<ExceptionEmitted>(
      _onExceptionEmitted,
      transformer: log(),
    );

    on<ForceLogoutButtonPressed>(
      _onForceLogoutButtonPressed,
      transformer: log(),
    );
    on<CommonPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<CommonTotalUnreadInitiated>(
      _onTotalUnread,
      transformer: log(),
    );
  }

  final ClearCurrentUserDataUseCase _clearCurrentUserDataUseCase;
  final SaveTokenFcmUseCase _saveTokenFcmUseCase;

  FutureOr<void> _onLoadingVisibilityEmitted(
    LoadingVisibilityEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(state.copyWith(
      isLoading: state.loadingCount == 0 && event.isLoading
          ? true
          : state.loadingCount == 1 && !event.isLoading || state.loadingCount <= 0
              ? false
              : state.isLoading,
      loadingCount: event.isLoading ? state.loadingCount.plus(1) : state.loadingCount.minus(1),
    ));
  }

  FutureOr<void> _onExceptionEmitted(ExceptionEmitted event, Emitter<CommonState> emit) {
    emit(state.copyWith(appExceptionWrapper: event.appExceptionWrapper));
  }

  FutureOr<void> _onForceLogoutButtonPressed(
    ForceLogoutButtonPressed event,
    Emitter<CommonState> emit,
  ) {
    return runBlocCatching(
      action: () async {
        await _clearCurrentUserDataUseCase.execute(const ClearCurrentUserDataInput());
        // await _saveTokenFcmUseCase.execute(const SaveTokenFcmInput(tokenFcm: ''));
        await navigator.replace(const AppRouteInfo.login());
      },
    );
  }

  FutureOr<void> _onMainPageInitiated(CommonPageInitiated event, Emitter<CommonState> emit) async {
    // await _getUsers(
    //   emit: emit,
    // );
  }

  FutureOr<void> _onTotalUnread(CommonTotalUnreadInitiated event, Emitter<CommonState> emit) async {
    // await _getTotal(
    //   emit: emit,
    // );
  }
}
