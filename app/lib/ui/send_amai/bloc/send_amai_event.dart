import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'send_amai_event.freezed.dart';

abstract class SendAmaiEvent extends BaseBlocEvent {
  const SendAmaiEvent();
}

@freezed
class SendAmaiPageInitiated extends SendAmaiEvent with _$SendAmaiPageInitiated {
  const factory SendAmaiPageInitiated() = _SendAmaiPageInitiated;
}

@freezed
class GetMemberSend extends SendAmaiEvent with _$GetMemberSend {
  const factory GetMemberSend({
    @Default(-1) int id,
  }) = _GetMemberSend;
}

@freezed
class SelectedMember extends SendAmaiEvent with _$SelectedMember {
  const factory SelectedMember({
    @Default(DonationRecipientEntry()) DonationRecipientEntry selectedMember,
  }) = _SelectedMember;
}

@freezed
class SelectAmai extends SendAmaiEvent with _$SelectAmai {
  const factory SelectAmai({
    @Default(0) int index,
    @Default(1) int amaiCount,
  }) = _SelectAmai;
}

@freezed
class SelectContent extends SendAmaiEvent with _$SelectContent {
  const factory SelectContent({
    required TextEditingController controller,
  }) = _SelectContent;
}

@freezed
class ChangeCount extends SendAmaiEvent with _$ChangeCount {
  const factory ChangeCount({
    @Default(0) int count,
  }) = _ChangeCount;
}

@freezed
class InputChange extends SendAmaiEvent with _$InputChange {
  const factory InputChange({
    @Default('') String input,
  }) = _InputChange;
}

@freezed
class DonateButton extends SendAmaiEvent with _$DonateButton {
  const factory DonateButton({
    required int type,
    required int id,
  }) = _DonateButton;
}

@freezed
class ChangeFocus extends SendAmaiEvent with _$ChangeFocus {
  const factory ChangeFocus({
    required bool focus,
  }) = _ChangeFocus;
}

@freezed
class ChangeFocusInput extends SendAmaiEvent with _$ChangeFocusInput {
  const factory ChangeFocusInput({
    required bool focus,
  }) = _ChangeFocusInput;
}

@freezed
class CheckValid extends SendAmaiEvent with _$CheckValid {
  const factory CheckValid({
    required int type,
    required int id,
  }) = _CheckValid;
}
