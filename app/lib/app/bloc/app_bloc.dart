import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';
import '../../utils/toast_message.dart';

@LazySingleton()
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc(
    // this._getInitialAppDataUseCase,
    // this._saveIsDarkModeUseCase,
    // this._saveLanguageCodeUseCase,
    this._getUsersUseCase,
    this._totalNotificationUseCase,
  ) : super(const AppState()) {
    on<IsLoggedInStatusChanged>(
      _onIsLoggedInStatusChanged,
      transformer: log(),
    );

    on<AppTotalNotifiChange>(
      _onTotalNotiChanged,
      transformer: throttleTime(),
    );

    // on<AppLanguageChanged>(
    //   _onAppLanguageChanged,
    //   transformer: log(),
    // );

    on<AppInitiated>(
      _onAppInitiated,
      transformer: log(),
    );
  }

  // final GetInitialAppDataUseCase _getInitialAppDataUseCase;
  // final SaveIsDarkModeUseCase _saveIsDarkModeUseCase;
  // final SaveLanguageCodeUseCase _saveLanguageCodeUseCase;
  final GetMeUseCase _getUsersUseCase;
  final GetTotalNotificationUseCase _totalNotificationUseCase;
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

    await _getUsers(emit: emit);
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
          commonBloc.add(const ForceLogoutButtonPressed());
        }
      },
      doOnError: (e) async {},
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
    );
  }
  // void _updateThemeSetting(bool isDarkTheme) {
  //   AppThemeSetting.currentAppThemeType = isDarkTheme ? AppThemeType.dark : AppThemeType.light;
  // }
}
