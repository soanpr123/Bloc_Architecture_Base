
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'infomation_profile_page_state.freezed.dart';

@freezed
class InfomationProfilePageState extends BaseBlocState with _$InfomationProfilePageState {
  const factory InfomationProfilePageState() = _InfomationProfilePageState;
}
