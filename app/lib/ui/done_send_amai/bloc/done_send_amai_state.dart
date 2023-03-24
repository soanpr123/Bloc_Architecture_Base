
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'done_send_amai_state.freezed.dart';

@freezed
class DoneSendAmaiState extends BaseBlocState with _$DoneSendAmaiState {
  const factory DoneSendAmaiState() = _DoneSendAmaiState;
}
