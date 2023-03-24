import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';

part 'app_state.freezed.dart';

@freezed
class AppState extends BaseBlocState with _$AppState {
  const factory AppState({
    @Default(LanguageCode.vn) LanguageCode languageCode,
    @Default(false) bool isLoggedIn,
    @Default(false) bool isDarkTheme,
    @Default(0) int total,
    @Default(false) bool reload,
    @Default(false) bool reloadHis,
    @Default(Profile()) Profile users,
    @Default(PopUpDonateEntry()) PopUpDonateEntry popUpDonateEntry,
  }) = _AppState;
}
