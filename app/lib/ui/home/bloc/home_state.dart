

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseBlocState with _$HomeState {
  const factory HomeState() = _HomeState;
}
