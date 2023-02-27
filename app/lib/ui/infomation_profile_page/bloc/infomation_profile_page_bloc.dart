import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

import '../../../utils/toast_message.dart';
import 'infomation_profile_page_event.dart';
import 'infomation_profile_page_state.dart';

@Injectable()
class InfomationProfileBloc extends BaseBloc<InfomationProfilePageEvent, InfomationProfilePageState> {
  InfomationProfileBloc(this._updateMeUseCase) : super(const InfomationProfilePageState()) {
    on<InfomationProfilePageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<InfomationProfileShowEditInput>(
      _onShoweditPress,
      transformer: log(),
    );
    on<InfomationProfilePageTextfieldInput>(
      _onTextFieldInput,
      transformer: log(),
    );
  }
  final UpdateMeUseCase _updateMeUseCase;
  FutureOr<void> _onMainPageInitiated(
    InfomationProfilePageInitiated event,
    Emitter<InfomationProfilePageState> emit,
  ) async {
    await updateMe(state.about, emit);
  }

  FutureOr<void> _onShoweditPress(
    InfomationProfileShowEditInput event,
    Emitter<InfomationProfilePageState> emit,
  ) async {
    emit(state.copyWith(showEdit: !event.show));
  }

  FutureOr<void> _onTextFieldInput(
    InfomationProfilePageTextfieldInput event,
    Emitter<InfomationProfilePageState> emit,
  ) async {
    emit(state.copyWith(about: event.text));
  }

  Future<void> updateMe(
    String name,
    Emitter<InfomationProfilePageState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        final response = await _updateMeUseCase
            .execute(UpdateMeInput(avt: appBloc.state.users.incognito?.avatar ?? '', about: name));
        if (response.data['status_code'] == 200) {
          appBloc.add(const AppInitiated());
          successToast(response.data['message']);
          emit(state.copyWith(showEdit: !state.showEdit, buttonState: AppElevatedButtonState.active));
        } else {
          errorToast(msg: response.data['message']);
        }
      },
      doOnSubscribe: () async {
        emit(state.copyWith(buttonState: AppElevatedButtonState.loading));
      },
      doOnSuccessOrError: () async {
        emit(state.copyWith(buttonState: AppElevatedButtonState.active));
      },
      handleLoading: false,
    );
  }
}
