import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'change_pass_event.freezed.dart';

abstract class ChangePassEvent extends BaseBlocEvent {
  const ChangePassEvent();
}

@freezed
class ChangePassPageInitiated extends ChangePassEvent with _$ChangePassPageInitiated {
  const factory ChangePassPageInitiated() = _ChangePassPageInitiated;
}

@freezed
class ChangePassTextInput extends ChangePassEvent with _$ChangePassTextInput {
  const factory ChangePassTextInput({
    required String currentPass,
  }) = _ChangePassTextInput;
}

@freezed
class ChangeNewPassTextInput extends ChangePassEvent with _$ChangeNewPassTextInput {
  const factory ChangeNewPassTextInput({
    required String newPass,
  }) = _ChangeNewPassTextInput;
}

@freezed
class ChangeConfirmPassTextInput extends ChangePassEvent with _$ChangeConfirmPassTextInput {
  const factory ChangeConfirmPassTextInput({
    required String confirmPass,
  }) = _ChangeConfirmPassTextInput;
}

@freezed
class ChangePassPress extends ChangePassEvent with _$ChangePassPress {
  const factory ChangePassPress() = _ChangePassPress;
}

@freezed
class ShowPassPress extends ChangePassEvent with _$ShowPassPress {
  const factory ShowPassPress({
    required bool showCurr,
  }) = _ShowPassPress;
}

@freezed
class ShowNewPassPress extends ChangePassEvent with _$ShowNewPassPress {
  const factory ShowNewPassPress({
    required bool showNew,
  }) = _ShowNewPassPress;
}

@freezed
class ShowConfiPassPress extends ChangePassEvent with _$ShowConfiPassPress {
  const factory ShowConfiPassPress({
    required bool showConf,
  }) = _ShowConfiPassPress;
}
