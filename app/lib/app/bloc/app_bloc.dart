import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../utils/toast_message.dart';

@LazySingleton()
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc(
    // this._getInitialAppDataUseCase,
    // this._saveIsDarkModeUseCase,
    // this._saveLanguageCodeUseCase,
    this._isLoggedInUseCase,
    this._clearCurrentUserDataUseCase,
    this._getUsersUseCase,
    this._totalNotificationUseCase,
    this._getPopUpDonateUseCase,
  ) : super(const AppState()) {
    on<IsLoggedInStatusChanged>(
      _onIsLoggedInStatusChanged,
      transformer: log(),
    );

    on<AppTotalNotifiChange>(
      _onTotalNotiChanged,
      transformer: throttleTime(),
    );

    on<AppReloadNotipage>(
      _onReloadNoti,
      transformer: log(),
    );
    on<AppReloadHistory>(
      _onReloadHist,
      transformer: log(),
    );

    on<AppInitiated>(
      _onAppInitiated,
      transformer: log(),
    );
    on<AppGetPopUpDonate>(
      _onAppGetPopUp,
      transformer: log(),
    );
  }

  // final GetInitialAppDataUseCase _getInitialAppDataUseCase;
  // final SaveIsDarkModeUseCase _saveIsDarkModeUseCase;
  // final SaveLanguageCodeUseCase _saveLanguageCodeUseCase;
  final GetMeUseCase _getUsersUseCase;
  final GetTotalNotificationUseCase _totalNotificationUseCase;
  final ClearCurrentUserDataUseCase _clearCurrentUserDataUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;
  final GetPopUpDonateUseCase _getPopUpDonateUseCase;
  bool get _isLoggedIn => runCatching(action: () => _isLoggedInUseCase.execute(const IsLoggedInInput())).when(
        success: (output) => output.isLoggedIn,
        failure: (e) => false,
      );
  void _onIsLoggedInStatusChanged(IsLoggedInStatusChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(isLoggedIn: event.isLoggedIn));
  }

  Future<void> _onTotalNotiChanged(AppTotalNotifiChange event, Emitter<AppState> emit) async {
    await runBlocCatching(
      action: () async {
        final output = await _totalNotificationUseCase.execute(
          const GetTotalNotificationInput(),
        );

        if (output.data['status_code'] == 200) {
          emit(state.copyWith(total: int.parse(output.data['data']['total_unread'].toString())));
        } else {
          emit(state.copyWith(total: 0));
        }
      },
      handleLoading: false,
    );
  }

  Future<void> _onReloadNoti(AppReloadNotipage event, Emitter<AppState> emit) async {
    emit(state.copyWith(reload: event.reload));
  }

  Future<void> _onReloadHist(AppReloadHistory event, Emitter<AppState> emit) async {
    emit(state.copyWith(reloadHis: !event.reloadHis));
  }

  // Future<void> _onAppLanguageChanged(AppLanguageChanged event, Emitter<AppState> emit) async {
  //   await runBlocCatching(
  //     action: () async {
  //       await _saveLanguageCodeUseCase
  //           .execute(SaveLanguageCodeInput(languageCode: event.languageCode));
  //       emit(state.copyWith(languageCode: event.languageCode));
  //     },
  //   );
  // }

  Future<void> _onAppInitiated(AppInitiated event, Emitter<AppState> emit) async {
    if (_isLoggedIn) {
      await runBlocCatching(
        doOnSubscribe: () async {
          // emit(state.copyWith(reload: true));
        },
        action: () async {
          final output = await _totalNotificationUseCase.execute(
            const GetTotalNotificationInput(),
          );

          if (output.data['status_code'] == 200) {
            emit(state.copyWith(total: int.parse(output.data['data']['total_unread'].toString())));
          } else {
            emit(state.copyWith(total: 0));
          }
        },
        handleLoading: false,
        handleError: event.handleErr,
        doOnError: (e) async {},
        doOnSuccessOrError: () async {},
      );

      await _getUsers(emit: emit);
    }
  }

  Future<void> _onAppGetPopUp(AppGetPopUpDonate event, Emitter<AppState> emit) async {
    if (_isLoggedIn) {
      await _getPopUpDonate(
          emit: emit, doOnSubscribe: () async => emit(state.copyWith(popUpDonateEntry: const PopUpDonateEntry())));
    }
  }

  Future<void> _getUsers({
    required Emitter<AppState> emit,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        final output = await _getUsersUseCase.execute(
          const GetMeInput(),
        );
        if (output.id != -1) {
          emit(state.copyWith(users: output));
        } else {
          errorToast(msg: 'Vui lòng đăng nhập lại để tiếp tục');
          await _clearCurrentUserDataUseCase.execute(const ClearCurrentUserDataInput());
          await Future<void>.delayed(const Duration(seconds: 2));
          await GetIt.instance.get<AppNavigator>().replace(const AppRouteInfo.login());
        }
      },
      doOnError: (e) async {},
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      handleError: false,
    );
  }

  Future<void> _getPopUpDonate({
    required Emitter<AppState> emit,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        final output = await _getPopUpDonateUseCase.execute(
          const GetPopUpDonateUseInput(),
        );
        if (output.donor != '') {
          emit(state.copyWith(popUpDonateEntry: output));
        } else {
          emit(state.copyWith(popUpDonateEntry: const PopUpDonateEntry()));
        }
      },
      doOnError: (e) async {},
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      handleError: false,
    );
  }
  // void _updateThemeSetting(bool isDarkTheme) {
  //   AppThemeSetting.currentAppThemeType = isDarkTheme ? AppThemeType.dark : AppThemeType.light;
  // }
}
