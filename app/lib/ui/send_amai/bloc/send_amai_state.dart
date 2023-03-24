import 'package:app/shared_view/body_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';
import '../../../base/bloc/base_state.dart';

part 'send_amai_state.freezed.dart';

@freezed
class SendAmaiState extends BaseBlocState with _$SendAmaiState {
  const factory SendAmaiState({
    @Default(0) int count,
    @Default(<DonationRecipientEntry>[]) List<DonationRecipientEntry> member,
    @Default(DonationRecipientEntry()) DonationRecipientEntry selectedMember,
    TextEditingController? controller,
    @Default(0) int index,
    @Default(1) int amaiCount,
    @Default('') String errAmai,
    @Default('') String note,
    @Default(APIRequestStatus.loaded) APIRequestStatus privateStatus,
    @Default(AppElevatedButtonState.active) AppElevatedButtonState publicStatus,
  }) = _SendAmaiState;
}
