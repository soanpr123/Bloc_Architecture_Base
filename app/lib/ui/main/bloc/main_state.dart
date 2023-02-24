import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_state.dart';

part 'main_state.freezed.dart';

@freezed
class MainState extends BaseBlocState with _$MainState {
  const factory MainState({
    @Default('') String id,
    @Default(Profile()) Profile users,
    @Default(0) int total,
  }) = _MainState;
}
