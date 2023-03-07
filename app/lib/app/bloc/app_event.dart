import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../base/bloc/base_event.dart';

part 'app_event.freezed.dart';

abstract class AppEvent extends BaseBlocEvent {
  const AppEvent();
}

@freezed
class IsLoggedInStatusChanged extends AppEvent with _$IsLoggedInStatusChanged {
  const factory IsLoggedInStatusChanged({
    required bool isLoggedIn,
  }) = _IsLoggedInStatusChanged;
}

@freezed
class AppThemeChanged extends AppEvent with _$AppThemeChanged {
  const factory AppThemeChanged({
    required bool isDarkTheme,
  }) = _AppThemeChanged;
}

@freezed
class AppTotalNotifiChange extends AppEvent with _$AppTotalNotifiChange {
  const factory AppTotalNotifiChange() = _AppTotalNotifiChange;
}

@freezed
class AppLanguageChanged extends AppEvent with _$AppLanguageChanged {
  const factory AppLanguageChanged({
    required LanguageCode languageCode,
  }) = _AppLanguageChanged;
}

@freezed
class AppInitiated extends AppEvent with _$AppInitiated {
  const factory AppInitiated({
    @Default(true) bool handleErr,
  }) = _AppInitiated;
}

@freezed
class AppReloadNotipage extends AppEvent with _$AppReloadNotipage {
  const factory AppReloadNotipage({
    @Default(false) bool reload,
  }) = _AppReloadNotipage;
}

@freezed
class AppReloadHistory extends AppEvent with _$AppReloadHistory {
  const factory AppReloadHistory({
    @Default(false) bool reloadHis,
  }) = _AppReloadHistory;
}
