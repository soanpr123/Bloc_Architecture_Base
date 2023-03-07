import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class AnnounmentBloc extends BaseBloc<AnnounmentEvent, AnnounmentState> {
  AnnounmentBloc(this._getAnnounmentCase, this._readNotificationUseCase) : super(AnnounmentState()) {
    on<AnnounmentPageInitiated>(
      _onAnnoumentInitiated,
      transformer: log(),
    );
    on<AnnounmentLoadMore>(
      _onUserLoadMore,
      transformer: log(),
    );
    on<AnnounmentPageRefreshed>(
      _onHomePageRefreshed,
      transformer: log(),
    );
    on<ReadAnnounment>(
      _readNotifi,
      transformer: log(),
    );
  }
  final GetAnnoumentnUseCase _getAnnounmentCase;
  final ReadNotificationUseCase _readNotificationUseCase;
  FutureOr<void> _onAnnoumentInitiated(AnnounmentPageInitiated event, Emitter<AnnounmentState> emit) async {
    await _getAnnounment(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(
        isShimmerLoading: true,
        apirequestNoti: APIRequestStatus.loading,
      )),
      doOnSuccessOrError: () async => emit(state.copyWith(
        isShimmerLoading: false,
      )),
    );
  }

  FutureOr<void> _onUserLoadMore(AnnounmentLoadMore event, Emitter<AnnounmentState> emit) async {
    await _getAnnounment(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onHomePageRefreshed(AnnounmentPageRefreshed event, Emitter<AnnounmentState> emit) async {
    await _getAnnounment(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async {
        emit(state.copyWith(
          isShimmerLoading: true,
          apirequestNoti: APIRequestStatus.loading,
        ));
      },
      doOnSuccessOrError: () async {
        emit(state.copyWith(isShimmerLoading: false));

        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  FutureOr<void> _readNotifi(ReadAnnounment event, Emitter<AnnounmentState> emit) async {
    appBloc.add(const AppInitiated());

    await navigator.push(AppRouteInfo.announcementDetail(event.slung));

    await _getAnnounment(
      emit: emit,
      isInitialLoad: true,
    );
  }

  Future<void> _getAnnounment({
    required Emitter<AnnounmentState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getAnnounmentCase.execute(const GetAnnoumentInput(), isInitialLoad);
        if (output.data.isNotEmpty) {
         
          emit(state.copyWith(notifi: output, apirequestNoti: APIRequestStatus.loaded));
        } else {
          emit(state.copyWith(notifi: output, apirequestNoti: APIRequestStatus.nodata));
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              loadUsersException: e,
              apirequestNoti: APIRequestStatus.connectionError,
            ));
          }
        } else {
          emit(state.copyWith(
            loadUsersException: e,
          ));
        }
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      handleError: false,
    );
  }
}
