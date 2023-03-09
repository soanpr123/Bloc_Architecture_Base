import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class WikiBloc extends BaseBloc<WikiEvent, WikiState> {
  WikiBloc(
    this._getWikiUseCase,
  ) : super(WikiState()) {
    on<WikiPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<WikiLoadMore>(
      _onWikiLoadMore,
      transformer: log(),
    );
    on<WikiPageRefreshed>(
      _onWikiPageRefreshed,
      transformer: log(),
    );
    on<ReadWiki>(
      _readWiki,
      transformer: log(),
    );
  }
  final GetWikiUseCase _getWikiUseCase;
  FutureOr<void> _onMainPageInitiated(WikiPageInitiated event, Emitter<WikiState> emit) async {
    await _getWiki(
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

  FutureOr<void> _onWikiLoadMore(WikiLoadMore event, Emitter<WikiState> emit) async {
    await _getWiki(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onWikiPageRefreshed(WikiPageRefreshed event, Emitter<WikiState> emit) async {
    await _getWiki(
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

  FutureOr<void> _readWiki(ReadWiki event, Emitter<WikiState> emit) async {
    await navigator.push(AppRouteInfo.wikiDetailPage(event.slung));
    appBloc.add(const AppInitiated(handleErr: false));
    await _getWiki(
      emit: emit,
      isInitialLoad: true,
    );
  }

  Future<void> _getWiki({
    required Emitter<WikiState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getWikiUseCase.execute(const GetWikiInput(), isInitialLoad);
        print(output.data);
        await Future<void>.delayed(const Duration(seconds: SymbolConstants.delayedApi));
        if (output.data.isNotEmpty) {
          emit(state.copyWith(wiki: output, apirequestNoti: APIRequestStatus.loaded));
        } else {
          emit(state.copyWith(wiki: output, apirequestNoti: APIRequestStatus.nodata));
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
