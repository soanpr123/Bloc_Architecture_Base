import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class HistoryAmaiBloc extends BaseBloc<HistoryAmaiEvent, HistoryAmaiState> {
  HistoryAmaiBloc(
    this._getHistoryUseCase,
  ) : super(HistoryAmaiState()) {
    on<HistoryPageInitiated>(
      _onHistoryPageInitiated,
      transformer: log(),
    );

    on<AmaiHistoryLoadMore>(
      _onHistoryLoadMore,
      transformer: log(),
    );

    on<AmaiHistoryPageRefreshed>(
      _onHistoryPageRefreshed,
      transformer: log(),
    );
  }
  final GetHistoryUseCase _getHistoryUseCase;
  final List<HistoryAmai> listDataNoti = [];
  FutureOr<void> _onHistoryPageInitiated(HistoryPageInitiated event, Emitter<HistoryAmaiState> emit) async {
    await _getHistory(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isShimmerLoading: false)),
    );
  }

  FutureOr<void> _onHistoryLoadMore(AmaiHistoryLoadMore event, Emitter<HistoryAmaiState> emit) async {
    await _getHistory(
      emit: emit,
      isInitialLoad: false,
      pages: state.page + 1,
      doOnSuccessOrError: () async {
        // appBloc.add(const AppInitiated());
        emit(state.copyWith(isShimmerLoading: false));

        event.completer.loadComplete();
      },
    );
  }

  FutureOr<void> _onHistoryPageRefreshed(AmaiHistoryPageRefreshed event, Emitter<HistoryAmaiState> emit) async {
    await _getHistory(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async {
        listDataNoti.clear();
        emit(state.copyWith(
          isShimmerLoading: true,
        ));
      },
      doOnSuccessOrError: () async {
        // appBloc.add(const AppInitiated());
        emit(state.copyWith(isShimmerLoading: false));

        event.completer.refreshCompleted();
      },
    );
  }

  Future<void> _getHistory({
    required Emitter<HistoryAmaiState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    int pages = 1,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getHistoryUseCase.execute(GetHistoryUseCaseInput(page: pages));
        // emit(state.copyWith(history: output));
        for (var item in output.notification) {
          // print(item.title);
          listDataNoti.add(item);
        }
  
        if ((output.currentPage) == (output.totalPage)) {
          emit(state.copyWith(
            history: listDataNoti,
            page: output.currentPage,
            enablePullNotifi: false,
          ));
        } else {
          emit(state.copyWith(
            history: listDataNoti,
            page: output.currentPage,
            enablePullNotifi: true,
          ));
        }
      },
      doOnError: (e) async {
        emit(state.copyWith(
          loadUsersException: e,
          enablePullNotifi: false,
          page: 1,
        ));
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
    );
  }
}
