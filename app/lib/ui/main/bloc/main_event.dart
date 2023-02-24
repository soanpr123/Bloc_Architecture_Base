import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'main_event.freezed.dart';

abstract class MainEvent extends BaseBlocEvent {
  const MainEvent();
}

@freezed
class MainPageInitiated extends MainEvent with _$MainPageInitiated {
  const factory MainPageInitiated() = _MainPageInitiated;
}
