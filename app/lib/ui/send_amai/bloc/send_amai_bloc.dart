import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class SendAmaiBloc extends BaseBloc<SendAmaiEvent, SendAmaiState> {
  SendAmaiBloc(this._getResourceUseCase, this._donateAmaiUseCase) : super(const SendAmaiState()) {
    on<SendAmaiPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<ChangeCounts>(
      _onChangeCount,
      transformer: log(),
    );
    on<GetMemberSend>(
      _onGetmember,
      transformer: log(),
    );
    on<SelectedMember>(
      _onSelectedMember,
      transformer: log(),
    );
    on<SelectContent>(
      _onSelectContent,
      transformer: log(),
    );
    on<SelectAmai>(
      _selectAmai,
      transformer: log(),
    );

    on<DonateButton>(
      _onDonateButton,
      transformer: log(),
    );
    on<InputChanges>(
      _inputChange,
      transformer: log(),
    );
    on<ChangeFocus>(
      _onChangeFocus,
      transformer: log(),
    );
    on<ChangeFocusInput>(
      _onChangeFocusInput,
      transformer: log(),
    );
    on<CheckValid>(
      _onChangeValid,
      transformer: log(),
    );
  }
  final GetResourceUseCase _getResourceUseCase;
  final DonateAmaiUseCase _donateAmaiUseCase;
  FutureOr<void> _onMainPageInitiated(SendAmaiPageInitiated event, Emitter<SendAmaiState> emit) async {
    appBloc.add(const AppInitiated(handleErr: true));
  }

  FutureOr<void> _onGetmember(GetMemberSend event, Emitter<SendAmaiState> emit) async {
    await getMember(emit: emit, event: event);
  }

  FutureOr<void> _onSelectContent(SelectContent event, Emitter<SendAmaiState> emit) async {
    emit(state.copyWith(controller: event.controller));
  }

  FutureOr<void> _selectAmai(SelectAmai event, Emitter<SendAmaiState> emit) async {
    if ((appBloc.state.users.totalAmais ?? 0) < event.amaiCount) {
      emit(state.copyWith(
        errAmai: 'Số Amai trong tài khoản ko đủ để thực hiện tặng.',
        index: event.index,
        amaiCount: event.amaiCount,
      ));
    } else {
      emit(state.copyWith(
        errAmai: '',
        index: event.index,
        amaiCount: event.amaiCount,
      ));
    }
  }

  FutureOr<void> _inputChange(InputChanges event, Emitter<SendAmaiState> emit) async {
    emit(state.copyWith(note: event.input));
  }

  FutureOr<void> _onSelectedMember(SelectedMember event, Emitter<SendAmaiState> emit) async {
    emit(state.copyWith(
      selectedMember: event.selectedMember,
      errUser: '',
    ));
    if (event.selectedMember.id == -1 || state.note == '') {
      emit(state.copyWith(publicStatus: AppElevatedButtonState.inactive, privateStatus: APIRequestStatus.error));
    } else {
      emit(state.copyWith(publicStatus: AppElevatedButtonState.active, privateStatus: APIRequestStatus.loaded));
    }
  }

  FutureOr<void> _onChangeCount(ChangeCounts event, Emitter<SendAmaiState> emit) async {
    emit(state.copyWith(
      count: event.count,
    ));
    if (state.count > 0) {
      emit(state.copyWith(
        errSend: '',
      ));
    }
    if (state.selectedMember.id == -1 || event.count == 0) {
      emit(state.copyWith(publicStatus: AppElevatedButtonState.inactive, privateStatus: APIRequestStatus.error));
    } else {
      emit(state.copyWith(publicStatus: AppElevatedButtonState.active, privateStatus: APIRequestStatus.loaded));
    }
  }

  FutureOr<void> _onChangeFocus(ChangeFocus event, Emitter<SendAmaiState> emit) async {
    emit(state.copyWith(focus: event.focus));
  }

  FutureOr<void> _onChangeFocusInput(ChangeFocusInput event, Emitter<SendAmaiState> emit) async {
    emit(state.copyWith(focusInput: event.focus));
  }

  FutureOr<void> _onChangeValid(CheckValid event, Emitter<SendAmaiState> emit) async {
    if (state.selectedMember.id == -1) {
      emit(state.copyWith(
        errUser: 'Người nhận không được để trống',
      ));

      return;
    }
    if (state.note.isEmpty) {
      emit(state.copyWith(
        errSend: 'Không được để trống',
        errUser: '',
      ));

      return;
    }
  }

  FutureOr<void> _onDonateButton(DonateButton event, Emitter<SendAmaiState> emit) async {
    if (state.selectedMember.id == -1) {
      emit(state.copyWith(
        errUser: 'Người nhận không được để trống',
      ));

      return;
    }
    if (state.note.isEmpty) {
      emit(state.copyWith(
        errSend: 'Không được để trống',
        errUser: '',
      ));

      return;
    }

    await runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(
          publicStatus: event.type == 1 ? AppElevatedButtonState.loading : AppElevatedButtonState.active,
          privateStatus: event.type == 1 ? APIRequestStatus.loaded : APIRequestStatus.loading,
          errSend: '',
          errUser: '',
        ));
      },
      action: () async {
        final out = await _donateAmaiUseCase.execute(DonateAmaiInput(
          receiveId: state.selectedMember.id ?? -1,
          amountAmais: state.amaiCount,
          donateType: event.type,
          note: state.note,
        ));
        if (out.data['status_code'] == 200) {
          successToast(out.data['message']);
          emit(state.copyWith(
            publicStatus: AppElevatedButtonState.active,
            privateStatus: APIRequestStatus.loaded,
          ));
          await navigator.push(AppRouteInfo.doneSendAmaiPage(event.id));
          emit(state.copyWith(
            publicStatus: AppElevatedButtonState.active,
            privateStatus: APIRequestStatus.loaded,
            amaiCount: 1,
            index: 0,
            selectedMember: const DonationRecipientEntry(),
            note: '',
            controller: TextEditingController(),
          ));
        } else {
          errorToast(msg: out.data['message']);
          emit(state.copyWith(
            publicStatus: AppElevatedButtonState.active,
            privateStatus: APIRequestStatus.loaded,
          ));
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            errorToast(msg: S.current.InternetException);
          }
        } else {}
      },
      handleError: false,
      handleLoading: false,
    );
  }

  Future<void> getMember({
    required Emitter<SendAmaiState> emit,
    required GetMemberSend event,
  }) async {
    return runBlocCatching(
      action: () async {
        final out = await _getResourceUseCase.execute(const GetResourceInput(type: 'donation_recipient'));

        if (out.memberSend != null && out.memberSend!.isNotEmpty) {
          if (event.id != -1) {
            emit(state.copyWith(
              member: out.memberSend ?? [],
              selectedMember: out.memberSend![out.memberSend!.indexWhere((element) => element.id == event.id)],
            ));
          } else {
            emit(state.copyWith(
              member: out.memberSend ?? [],
              selectedMember: const DonationRecipientEntry(),
            ));
          }
        } else {
          emit(state.copyWith(
            member: [],
          ));
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {}
        } else {}
      },
      handleLoading: false,
      handleError: false,
    );
  }
}
