import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class RankingPageBloc extends BaseBloc<RankingPageEvent, RankingPageState> {
  RankingPageBloc(this._getLeaderBroadUseCase) : super(const RankingPageState()) {
    on<RankingPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }
  final GetLeaderBroadUseCase _getLeaderBroadUseCase;
  FutureOr<void> _onMainPageInitiated(RankingPageInitiated event, Emitter<RankingPageState> emit) async {
    await getLeaderBroad(emit: emit);
  }

  Future<void> getLeaderBroad({required Emitter<RankingPageState> emit}) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(apiRequestStatus: APIRequestStatus.loading));
      },
      action: () async {
        final output = await _getLeaderBroadUseCase.execute(GetLeaderBroadInput());
        await Future<void>.delayed(const Duration(seconds: SymbolConstants.delayedApi));
        if (output.isEmpty) {
          emit(state.copyWith(apiRequestStatus: APIRequestStatus.nodata));
        } else {
          emit(state.copyWith(
            apiRequestStatus: APIRequestStatus.loaded,
            leaderBroad: output,
          ));
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              apiRequestStatus: APIRequestStatus.connectionError,
            ));
          }
        } else {
          emit(state.copyWith(
            apiRequestStatus: APIRequestStatus.error,
          ));
        }
      },
      handleLoading: false,
      handleError: false,
    );
  }
}
