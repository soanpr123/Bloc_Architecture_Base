import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

import 'infomation_profile_page_event.dart';
import 'infomation_profile_page_state.dart';

@Injectable()
class InfomationProfileBloc extends BaseBloc<InfomationProfilePageEvent, InfomationProfilePageState> {
  InfomationProfileBloc(this._updateMeUseCase) : super(const InfomationProfilePageState()) {
    on<InfomationProfilePageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }
  final UpdateMeUseCase _updateMeUseCase;
  FutureOr<void> _onMainPageInitiated(
      InfomationProfilePageInitiated event, Emitter<InfomationProfilePageState> emit) async {}
}
