import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

part 'common_state.freezed.dart';

@freezed
class CommonState extends BaseBlocState with _$CommonState {
  const factory CommonState({
    AppExceptionWrapper? appExceptionWrapper,
    @Default(0) int loadingCount,
    @Default(false) bool isLoading,
    @Default(Profile()) Profile users,
    @Default(0) int total,
  }) = _CommonState;
}
