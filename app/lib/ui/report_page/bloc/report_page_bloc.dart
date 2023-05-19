import 'dart:async';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';
import '../sucess_report_dialog.dart';

@Injectable()
class ReportPageBloc extends BaseBloc<ReportPageEvent, ReportPageState> {
  ReportPageBloc(this._createFeedBackUseCase, this._getResourceUseCase, this._uploadImageuseCase)
      : super(const ReportPageState()) {
    on<ReportPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<GetIssueReportPage>(
      _onGetIssue,
      transformer: log(),
    );
    on<ChangeCount>(
      _onChangeCount,
      transformer: log(),
    );
    on<PickImage>(
      _onPickImage,
      transformer: log(),
    );
    on<SelectIssueReportPage>(
      _onSelectIssue,
      transformer: log(),
    );
    on<ChangeFocusInputText>(
      _onChangeFocus,
      transformer: log(),
    );
    on<DeleteImage>(
      _onDeleteImage,
      transformer: log(),
    );
    on<ButtonSubmit>(
      _onSubmit,
      transformer: log(),
    );
    on<InputChange>(
      _onInputChange,
      transformer: log(),
    );
  }
  final CreateFeedBackUseCase _createFeedBackUseCase;
  final GetResourceUseCase _getResourceUseCase;
  final UploadImageUseCase _uploadImageuseCase;
  final List<ErrorTypeEntry> issueSelect = [];
  final List<ImageUpload> imageUpload = [];

  FutureOr<void> _onMainPageInitiated(ReportPageInitiated event, Emitter<ReportPageState> emit) async {
    appBloc.add(const AppInitiated(handleErr: true));
  }

  FutureOr<void> _onChangeFocus(ChangeFocusInputText event, Emitter<ReportPageState> emit) async {
    emit(state.copyWith(focusInput: event.focus));
  }

  FutureOr<void> _onInputChange(InputChange event, Emitter<ReportPageState> emit) async {
    if (issueSelect.isEmpty || event.input.isEmpty) {
      emit(state.copyWith(
          buttonState: AppElevatedButtonState.inactive, issueSelect: [...state.issueSelect], input: event.input,));
    } else {
      emit(state.copyWith(
          buttonState: AppElevatedButtonState.active, issueSelect: [...state.issueSelect], input: event.input,));
    }
  }

  FutureOr<void> _onSubmit(ButtonSubmit event, Emitter<ReportPageState> emit) async {
    // emit(state.copyWith(focusInput: event.focus));

    if (state.input.isEmpty) {
      emit(state.copyWith(errNote: 'Không được bỏ trống trường này.'));

      return;
    }
    if (state.issueSelect.isEmpty) {
      emit(state.copyWith(errNote: '', errIssue: 'Vui lòng chọn vấn đề'));
    }
    await _submit(emit: emit);
  }

  FutureOr<void> _onChangeCount(ChangeCount event, Emitter<ReportPageState> emit) async {
    emit(state.copyWith(count: event.count));
  }

  FutureOr<void> _onSelectIssue(SelectIssueReportPage event, Emitter<ReportPageState> emit) async {
    if (issueSelect.where((e) => e.id == event.issueSelect.id).isNotEmpty) {
      issueSelect.remove(event.issueSelect);
    } else {
      issueSelect.add(event.issueSelect);
    }
    if (issueSelect.isEmpty || state.input.isEmpty) {
      emit(state.copyWith(
          buttonState: AppElevatedButtonState.inactive, issueSelect: [...issueSelect], input: state.input,));
    } else {
      emit(state.copyWith(
          buttonState: AppElevatedButtonState.active, issueSelect: [...issueSelect], input: state.input,));
    }


  }

  FutureOr<void> _onPickImage(PickImage event, Emitter<ReportPageState> emit) async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        await _updateloadImage(emit: emit, avt: File(images[i].path));
      }
    } else {
      errorToast(msg: 'Có lỗi khi chọn ảnh ');
    }
  }

  FutureOr<void> _onDeleteImage(DeleteImage event, Emitter<ReportPageState> emit) async {
    imageUpload.removeAt(event.index);
    emit(state.copyWith(
      image: [...imageUpload],
    ));
  }

  FutureOr<void> _onGetIssue(GetIssueReportPage event, Emitter<ReportPageState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(loading: APIRequestStatus.loading));
      },
      action: () async {
        final out = await _getResourceUseCase.execute(const GetResourceInput(type: 'error_types'));

        if (out.errorType != null && out.errorType!.isNotEmpty) {
          emit(state.copyWith(issue: out.errorType!, loading: APIRequestStatus.loaded));
        } else {
          if (out.errorType != null && out.errorType!.isNotEmpty) {
            emit(state.copyWith(issue: [], loading: APIRequestStatus.nodata));
          }
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              loading: APIRequestStatus.connectionError,
            ));
          }
        } else {
          emit(state.copyWith(
            loading: APIRequestStatus.error,
          ));
        }
      },
      handleError: false,
      handleLoading: false,
    );
  }

  Future<void> _updateloadImage({required Emitter<ReportPageState> emit, required File avt}) async {
    return runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(loadingImage: APIRequestStatus.loading)),
      action: () async {
        final out = await _uploadImageuseCase.execute(UploadImageInput(file: avt, type: 'avatar'));

        if (out.statusCode == 200) {
          // await _updateAvt(emit: emit, avt: out.url);

          if (imageUpload.length < 3) {
            imageUpload.add(out);
            emit(state.copyWith(image: [...imageUpload], loadingImage: APIRequestStatus.loaded));
          } else {
            emit(state.copyWith(loadingImage: APIRequestStatus.loaded));
          }
        } else {
          emit(state.copyWith(loadingImage: APIRequestStatus.error));
        }
      },
      // doOnSubscribe: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.loading)),
      // doOnSuccessOrError: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.active)),
      handleLoading: false,
      handleError: false,
    );
  }

  Future<void> _submit({required Emitter<ReportPageState> emit}) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(buttonState: AppElevatedButtonState.loading));
      },
      action: () async {
        final Map<String, dynamic> request = {};
        final List<int> type = [];
        for (int i = 0; i < state.image.length; i++) {
          request.addAll(
            {'images[$i][url]': state.image[i].url, 'images[$i][thumb]': state.image[i].thumb},
          );
        }
        for (int i = 0; i < state.issueSelect.length; i++) {
          type.add(state.issueSelect[i].id ?? 0);
        }
        request.addAll({'error_type': type});
        request.addAll({'content': state.input});
   
        // final List<ImageUpload> images = [];:
        final out = await _createFeedBackUseCase.execute(CreateFeedBackInput(request: request));

        if (out.data['status_code'] == 200) {
          // await _updateAvt(emit: emit, avt: out.url);

          emit(state.copyWith(buttonState: AppElevatedButtonState.active));
          await navigator.showDialog(
              AppPopupInfo.bottomSheet(
                child: SucessReportDialog(
                  reportPageBloc: appBloc,
                  appNavigator: navigator,
                ),
              ),
              barrierDismissible: true,);
        } else {
          errorToast(msg: out.data['message']);
          emit(state.copyWith(buttonState: AppElevatedButtonState.active));
        }
      },
      // doOnSubscribe: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.loading)),
      // doOnSuccessOrError: () async => emit(state.copyWith(changeAvt: AppElevatedButtonState.active)),
      handleLoading: false,
      handleError: false,
    );
  }
}
