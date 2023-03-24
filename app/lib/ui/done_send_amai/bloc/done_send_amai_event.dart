import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'done_send_amai_event.freezed.dart';

abstract class DoneSendAmaiEvent extends BaseBlocEvent {
  const DoneSendAmaiEvent();
}

@freezed
class DoneSendPageInitiated extends DoneSendAmaiEvent with _$DoneSendPageInitiated {
  const factory DoneSendPageInitiated() = _DoneSendPageInitiated;
}
