import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'splash_event.freezed.dart';

abstract class SplashEvent extends BaseBlocEvent {
  const SplashEvent();
}

@freezed
class SplashInitiated extends SplashEvent with _$SplashInitiated {
  const factory SplashInitiated() = _SplashInitiated;
}
