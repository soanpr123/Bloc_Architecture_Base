
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState extends BaseBlocState with _$SplashState {
  const factory SplashState({
    @Default(false) bool isLoggedIn,
  }) = _SplashState;
}
