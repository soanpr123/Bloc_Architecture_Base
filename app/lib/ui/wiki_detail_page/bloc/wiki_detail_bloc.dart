import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class WikiDetailBloc extends BaseBloc<WikiDetailEvent, WikiDetailState> {
  WikiDetailBloc(
    this._getWikiUseCase,
  ) : super(const WikiDetailState()) {
    on<WikiDetailPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );

    on<WikiDetailPageShowBack>(
      _onWikiShow,
      transformer: log(),
    );
  }
  final WikiDetailUseCase _getWikiUseCase;
  FutureOr<void> _onMainPageInitiated(WikiDetailPageInitiated event, Emitter<WikiDetailState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(apiRequestStatus: APIRequestStatus.loading));
      },
      action: () async {
        final output = await _getWikiUseCase.execute(WikiDetailInput(slungs: event.slungs));
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

  FutureOr<void> _onWikiShow(
    WikiDetailPageShowBack event,
    Emitter<WikiDetailState> emit,
  ) async {
    emit(state.copyWith(show: event.show));
  }
}
