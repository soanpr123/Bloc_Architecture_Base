import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class AmaiMemberBloc extends BaseBloc<AmaiMemberEvent, AmaiMemberState> {
  AmaiMemberBloc(
    this._getMemberUseCase,
  ) : super(AmaiMemberState()) {
    on<MemberPageInitiated>(
      _onMemberPageInitiated,
      transformer: log(),
    );

    on<MemberLoadMore>(
      _onMemberLoadMore,
      transformer: log(),
    );
    on<MemberPageRefreshed>(
      _onMemberPageRefreshed,
      transformer: log(),
    );
  }

  final GetMemberUseCase _getMemberUseCase;
  FutureOr<void> _onMemberPageInitiated(MemberPageInitiated event, Emitter<AmaiMemberState> emit) async {
    await getMember(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(state.copyWith(
        isShimmerLoading: true,
        apirequest: APIRequestStatus.loading,
      )),
      doOnSuccessOrError: () async => emit(state.copyWith(
        isShimmerLoading: false,
      )),
    );
  }

  FutureOr<void> _onMemberLoadMore(MemberLoadMore event, Emitter<AmaiMemberState> emit) async {
    await getMember(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onMemberPageRefreshed(MemberPageRefreshed event, Emitter<AmaiMemberState> emit) async {
    await getMember(
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async {
        emit(state.copyWith(
          isShimmerLoading: true,
          apirequest: APIRequestStatus.loading,
        ));
      },
      doOnSuccessOrError: () async {
        emit(state.copyWith(
          isShimmerLoading: false,
        ));

        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  Future<void> getMember({
    required Emitter<AmaiMemberState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(
          loadUsersException: null,
        ));
        final output = await _getMemberUseCase.execute(const GetMemberInput(), isInitialLoad);
        await Future<void>.delayed(const Duration(seconds: SymbolConstants.delayedApi));
        if (output.data.isNotEmpty) {
          // appBloc.add(const AppInitiated());
          emit(state.copyWith(
            member: output,
            apirequest: APIRequestStatus.loaded,
          ));
        } else {
          emit(state.copyWith(
            member: output,
            apirequest: APIRequestStatus.nodata,
          ));
        }
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              loadUsersException: e,
              apirequest: APIRequestStatus.connectionError,
              enablePullNotifi: false,
              page: 1,
            ));
          }
        } else {
          emit(state.copyWith(
            loadUsersException: e,
            enablePullNotifi: false,
            page: 1,
          ));
        }
      },
      handleError: false,
      handleLoading: false,
    );
  }
}
