import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../base_event.dart';

part 'common_event.freezed.dart';

abstract class CommonEvent extends BaseBlocEvent {
  const CommonEvent();
}

@freezed
class ExceptionEmitted extends CommonEvent with _$ExceptionEmitted {
  const factory ExceptionEmitted({
    required AppExceptionWrapper appExceptionWrapper,
  }) = _ExceptionEmitted;
}

@freezed
class LoadingVisibilityEmitted extends CommonEvent with _$LoadingVisibilityEmitted {
  const factory LoadingVisibilityEmitted({
    required bool isLoading,
  }) = _LoadingVisibilityEmitted;
}

@freezed
class ForceLogoutButtonPressed extends CommonEvent with _$ForceLogoutButtonPressed {
  const factory ForceLogoutButtonPressed() = _ForceLogoutButtonPressed;
}

@freezed
class CommonPageInitiated extends CommonEvent with _$CommonPageInitiated {
  const factory CommonPageInitiated() = _CommonPageInitiated;
}

@freezed
class CommonTotalUnreadInitiated extends CommonEvent with _$CommonTotalUnreadInitiated {
  const factory CommonTotalUnreadInitiated() = _CommonTotalUnreadInitiated;
}
