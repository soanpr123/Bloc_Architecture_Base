import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class AnouncementDetailBloc extends BaseBloc<AnouncementDetailEvent, AnouncementDetailState> {
  AnouncementDetailBloc(this._announcementDetailUseCase, this._annoumentUseCase)
      : super(const AnouncementDetailState()) {
    on<AnouncementPageInitiated>(
      _onAnnouncementPageInitiated,
      transformer: log(),
    );
    on<AnouncementPageShowBack>(
      _onAnnouncementShow,
      transformer: log(),
    );
  }

  final AnnouncementDetailUseCase _announcementDetailUseCase;
  final ReadAnnoumentUseCase _annoumentUseCase;
  FutureOr<void> _onAnnouncementPageInitiated(
    AnouncementPageInitiated event,
    Emitter<AnouncementDetailState> emit,
  ) async {
    await runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(apiRequestStatus: APIRequestStatus.loading));
      },
      action: () async {
        await _annoumentUseCase.execute(ReadAnnoumentInput(id: event.slungs));
        final output = await _announcementDetailUseCase.execute(AnnouncementDetailInput(slungs: event.slungs));
        await Future<void>.delayed(const Duration(seconds: SymbolConstants.delayedApi));
        emit(state.copyWith(announcementDetail: output));
        emit(state.copyWith(apiRequestStatus: APIRequestStatus.loaded));
      },
      handleLoading: false,
      handleError: false,
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(apiRequestStatus: APIRequestStatus.connectionError));
          }
        } else {
          emit(state.copyWith(apiRequestStatus: APIRequestStatus.nodata));
        }
      },
    );
  }

  FutureOr<void> _onAnnouncementShow(
    AnouncementPageShowBack event,
    Emitter<AnouncementDetailState> emit,
  ) async {
    emit(state.copyWith(show: event.show));
  }
}
