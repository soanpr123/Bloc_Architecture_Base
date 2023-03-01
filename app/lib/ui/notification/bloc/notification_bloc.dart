import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class NotificationBloc extends BaseBloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._getNotificationUseCase, this._getNotificationUnreadUseCase, this._readNotificationUseCase,
      this._allNotificationUseCase)
      : super(NotificationState()) {
    on<NotificationPageInitiated>(
      _onNotifiPageInitiated,
      transformer: log(),
    );
    on<NotificationLoadMore>(
      _onUserLoadMore,
      transformer: log(),
    );

    on<NotificationPageRefreshed>(
      _onHomePageRefreshed,
      transformer: log(),
    );

    on<NotificationUnreadLoadMore>(
      _onUnreadLoadMore,
      transformer: log(),
    );

    on<NotificationUnreadPageRefreshed>(
      _onUnreadRefreshed,
      transformer: log(),
    );

    on<ReadNotification>(
      _readNotifi,
      transformer: log(),
    );
    on<NotificationonTapTab>(
      _onTapTab,
      transformer: log(),
    );
    on<ReadAllNotifiPress>(
      _onReadAll,
      transformer: log(),
    );
  }

  final GetNotificationUseCase _getNotificationUseCase;
  final GetNotificationUnreadUseCase _getNotificationUnreadUseCase;
  final ReadNotificationUseCase _readNotificationUseCase;
  final ReadAllNotificationUseCase _allNotificationUseCase;
  final List<AppNotification> listDataNoti = [];
  FutureOr<void> _onNotifiPageInitiated(NotificationPageInitiated event, Emitter<NotificationState> emit) async {
    appBloc.add(const AppInitiated());
    await _getNotifi(
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

    await _getNotifiUnread(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async =>
          emit(state.copyWith(isShimmerLoadingUnread: true, apirequestUnread: APIRequestStatus.loading)),
      doOnSuccessOrError: () async => emit(state.copyWith(
        isShimmerLoadingUnread: false,
      )),
    );
  }

  FutureOr<void> _onUserLoadMore(NotificationLoadMore event, Emitter<NotificationState> emit) async {
    await _getNotifi(
      emit: emit,
      isInitialLoad: false,
      pages: state.page + 1,
    );
  }

  void _onTapTab(NotificationonTapTab event, Emitter<NotificationState> emit) {
    Log.d(event.tabController.index);
    emit(state.copyWith(curentTab: event.tabController.index));
  }

  FutureOr<void> _onReadAll(ReadAllNotifiPress event, Emitter<NotificationState> emit) async {
    return runBlocCatching(
      doOnSubscribe: () async {},
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _allNotificationUseCase.execute(const ReadAllNotificationInput());
        if (output.data['status_code'] == 200) {
          appBloc.add(const AppInitiated());

          await _getNotifi(
            emit: emit,
            isInitialLoad: true,
          );
          await _getNotifiUnread(
            emit: emit,
            isInitialLoad: true,
          );
        } else {
          errorToast(msg: output.data['message']);
        }
        // for (var item in output.notification) {
        //   // print(item.title);
        //   listDataNoti.add(item);
        // }
        // if ((output.currentPage) == (output.totalPage)) {
        //   emit(state.copyWith(
        //     users: listDataNoti,
        //     page: output.currentPage,
        //     enablePullNotifi: false,
        //   ));
        // } else {
        //   emit(state.copyWith(
        //     users: listDataNoti,
        //     page: output.currentPage,
        //     enablePullNotifi: true,
        //   ));
        // }
      },
      doOnError: (e) async {},
      handleLoading: false,
    );
  }

  FutureOr<void> _readNotifi(ReadNotification event, Emitter<NotificationState> emit) async {
    // ignore: unawaited_futures
    await _readNotificationUseCase.execute(ReadNotificationInput(id: event.id));
    // GetIt.instance.get<MainBloc>().add(const MainPageInitiated());
    appBloc.add(const AppInitiated());

    if (event.type == 'announcements') {
      await navigator.push(AppRouteInfo.announcementDetail(event.slung));
    } else if (event.type == 'lunch_menus') {
      await navigator.push(const AppRouteInfo.amaiStore());
    }
    await _getNotifi(
      emit: emit,
      isInitialLoad: true,
    );
    await _getNotifiUnread(
      emit: emit,
      isInitialLoad: true,
    );
  }

  FutureOr<void> _onHomePageRefreshed(NotificationPageRefreshed event, Emitter<NotificationState> emit) async {
    await _getNotifi(
      emit: emit,
      isInitialLoad: true,
      pages: 1,
      doOnSubscribe: () async {
        listDataNoti.clear();
        emit(state.copyWith(
          isShimmerLoading: true,
          apirequestNoti: APIRequestStatus.loading,
        ));
      },
      doOnSuccessOrError: () async {
        appBloc.add(const AppInitiated());
        emit(state.copyWith(isShimmerLoading: false));

        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  FutureOr<void> _onUnreadLoadMore(NotificationUnreadLoadMore event, Emitter<NotificationState> emit) async {
    await _getNotifiUnread(
      emit: emit,
      isInitialLoad: false,
      pages: state.page + 1,
    );
  }

  FutureOr<void> _onUnreadRefreshed(NotificationUnreadPageRefreshed event, Emitter<NotificationState> emit) async {
    await _getNotifiUnread(
      emit: emit,
      isInitialLoad: true,
      pages: 1,
      doOnSubscribe: () async {
        listDataNoti.clear();
        emit(state.copyWith(
          isShimmerLoadingUnread: true,
          apirequestUnread: APIRequestStatus.loading,
        ));
      },
      doOnSuccessOrError: () async {
        // GetIt.instance.get<MainBloc>().add(const MainPageInitiated());
        appBloc.add(const AppInitiated());
        emit(state.copyWith(
          isShimmerLoadingUnread: false,
        ));

        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  Future<void> _getNotifi({
    required Emitter<NotificationState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    int pages = 1,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadUsersException: null));
        final output = await _getNotificationUseCase.execute(GetNotificationInput(page: pages), isInitialLoad);
        if (output.data.isNotEmpty) {
          emit(state.copyWith(notifi: output, apirequestNoti: APIRequestStatus.loaded));
        } else {
          emit(state.copyWith(notifi: output, apirequestNoti: APIRequestStatus.nodata));
        }

        // for (var item in output.notification) {
        //   // print(item.title);
        //   listDataNoti.add(item);
        // }
        // if ((output.currentPage) == (output.totalPage)) {
        //   emit(state.copyWith(
        //     users: listDataNoti,
        //     page: output.currentPage,
        //     enablePullNotifi: false,
        //   ));
        // } else {
        //   emit(state.copyWith(
        //     users: listDataNoti,
        //     page: output.currentPage,
        //     enablePullNotifi: true,
        //   ));
        // }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          emit(state.copyWith(
            loadUsersException: e,
            apirequestNoti: APIRequestStatus.connectionError,
            enablePullNotifi: false,
            page: 1,
          ));
        } else {
          emit(state.copyWith(
            loadUsersException: e,
            enablePullNotifi: false,
            page: 1,
          ));
        }
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      handleError: false,
    );
  }

  Future<void> _getNotifiUnread({
    required Emitter<NotificationState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    int pages = 1,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(loadNotifiUnreadException: null));
        final output = await _getNotificationUnreadUseCase.execute(const GetNotificationUnreadInput(), isInitialLoad);
        if (output.data.isNotEmpty) {
          emit(state.copyWith(notifiUnread: output, apirequestUnread: APIRequestStatus.loaded));
        } else {
          emit(state.copyWith(notifiUnread: output, apirequestUnread: APIRequestStatus.nodata));
        }

        // for (var item in output.notification) {
        //   // print(item.title);
        //   listDataNoti.add(item);
        // }
        // if ((output.currentPage) == (output.totalPage)) {
        //   emit(state.copyWith(
        //     users: listDataNoti,
        //     page: output.currentPage,
        //     enablePullNotifi: false,
        //   ));
        // } else {
        //   emit(state.copyWith(
        //     users: listDataNoti,
        //     page: output.currentPage,
        //     enablePullNotifi: true,
        //   ));
        // }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          emit(state.copyWith(
            loadUsersException: e,
            apirequestUnread: APIRequestStatus.connectionError,
            enablePullNotifi: false,
            page: 1,
          ));
        } else {
          emit(state.copyWith(
            loadUsersException: e,
            enablePullNotifi: false,
            page: 1,
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
