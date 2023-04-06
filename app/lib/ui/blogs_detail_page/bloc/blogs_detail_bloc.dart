import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class BlogsDetailBloc extends BaseBloc<BlogsDetailEvent, BlogsDetailState> {
  BlogsDetailBloc(
      this._blogsDetailUseCase, this._comentUseCase, this._blogsUseCase, this._likeComentUseCase, this._sendAmaiUseCase)
      : super(const BlogsDetailState()) {
    on<BlogsDetailPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
    on<BlogsPageShowBack>(
      _onBlogsShow,
      transformer: log(),
    );
    on<Hidebotom>(
      _onHideBotom,
      transformer: log(),
    );
    on<LikeBlogs>(
      likeBlogs,
      transformer: log(),
    );
    on<SendAmai>(
      voteAmai,
      transformer: log(),
    );
    on<LikeComment>(
      likeComment,
      transformer: log(),
    );
  }

  final BlogsDetailUseCase _blogsDetailUseCase;
  final GetComentUseCase _comentUseCase;
  final LikeBlogsUseCase _blogsUseCase;
  final LikeComentUseCase _likeComentUseCase;
  final SendAmaiUseCase _sendAmaiUseCase;
  double _last = 0;

  FutureOr<void> _onMainPageInitiated(BlogsDetailPageInitiated event, Emitter<BlogsDetailState> emit) async {
    await getDetailBlogs(slungs: event.slungs, emit: emit);
  }

  Future<void> getDetailBlogs({required String slungs, required Emitter<BlogsDetailState> emit}) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(apiRequestStatus: APIRequestStatus.loading));
      },
      action: () async {
        final output = await _blogsDetailUseCase.execute(BlogsDetailInput(slungs: slungs));
        await Future<void>.delayed(const Duration(seconds: SymbolConstants.delayedApi));
        if (output.id == -1) {
          emit(state.copyWith(apiRequestStatus: APIRequestStatus.nodata));
        } else {
          emit(state.copyWith(
            apiRequestStatus: APIRequestStatus.loaded,
            users: output,
            isLiked: output.isLiked ?? 0,
            isAmaiVotes: output.isVotedAmai ?? 0,
            totalAmaiVotes: output.totalAmais ?? 0,
            totalLikes: output.totalLikes ?? 0,
          ));
          await getComment(emit: emit, slungs: slungs);
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

  Future<void> getComment({required String slungs, required Emitter<BlogsDetailState> emit}) async {
    return runBlocCatching(
      action: () async {
        final output = await _comentUseCase.execute(GetComentUseCaseInput(slungs: slungs));
        if (output.isNotEmpty) {
          emit(state.copyWith(comment: output));
        }
      },
      handleLoading: false,
      handleError: false,
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
    );
  }

  FutureOr<void> likeBlogs(LikeBlogs event, Emitter<BlogsDetailState> emit) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(likeStatus: APIRequestStatus.loading));
      },
      action: () async {
        final output = await _blogsUseCase.execute(LikeBlogsInput(slungs: event.slungs));
        if (output.data['status_code'] == 200) {
          if (state.isLiked == 1) {
            emit(state.copyWith(
              isLiked: 0,
              totalLikes: state.totalLikes - 1,
              apiRequestStatus: APIRequestStatus.loaded,
              likeStatus: APIRequestStatus.loaded,
            ));
          } else {
            emit(state.copyWith(
              isLiked: 1,
              totalLikes: state.totalLikes + 1,
              apiRequestStatus: APIRequestStatus.loaded,
              likeStatus: APIRequestStatus.loaded,
            ));
          }
        } else {
          errorToast(msg: output.data['message']);
          emit(state.copyWith(likeStatus: APIRequestStatus.loaded));
        }
      },
      handleLoading: false,
      handleError: false,
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              apiRequestStatus: APIRequestStatus.connectionError,
              likeStatus: APIRequestStatus.loaded,
            ));
          }
        } else {
          emit(state.copyWith(
            apiRequestStatus: APIRequestStatus.error,
            likeStatus: APIRequestStatus.loaded,
          ));
        }
      },
    );
  }

  FutureOr<void> voteAmai(SendAmai event, Emitter<BlogsDetailState> emit) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(sendAmaiStatus: APIRequestStatus.loading));
      },
      action: () async {
        final output = await _sendAmaiUseCase.execute(SendAmaiInput(slungs: event.slungs));
        if (output.data['status_code'] == 200) {
          emit(state.copyWith(
            isAmaiVotes: 1,
            totalAmaiVotes: state.totalAmaiVotes + 1,
            sendAmaiStatus: APIRequestStatus.loaded,
          ));
        } else {
          errorToast(msg: output.data['message']);
          emit(state.copyWith(sendAmaiStatus: APIRequestStatus.loaded));
        }
      },
      handleLoading: false,
      handleError: false,
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              apiRequestStatus: APIRequestStatus.connectionError,
              sendAmaiStatus: APIRequestStatus.loaded,
            ));
          }
        } else {
          emit(state.copyWith(
            apiRequestStatus: APIRequestStatus.error,
            sendAmaiStatus: APIRequestStatus.loaded,
          ));
        }
      },
    );
  }

  FutureOr<void> likeComment(LikeComment event, Emitter<BlogsDetailState> emit) async {
    return runBlocCatching(
      doOnSubscribe: () async {},
      action: () async {
        final output = await _likeComentUseCase.execute(LikeComentInput(slungs: event.slungs, id: event.id));
        if (output.data['status_code'] == 200) {
          await getComment(slungs: event.slungs, emit: emit);
        }
      },
      handleLoading: false,
      handleError: false,
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
    );
  }

  FutureOr<void> _onBlogsShow(
    BlogsPageShowBack event,
    Emitter<BlogsDetailState> emit,
  ) async {
    emit(state.copyWith(show: event.show));
  }

  FutureOr<void> _onHideBotom(
    Hidebotom event,
    Emitter<BlogsDetailState> emit,
  ) async {
    final current = event.offset;
    double botttom = event.bottom;
    double pading = event.padding;
    botttom += _last - current;
    pading += _last - current;

    if (botttom <= -70) {
      botttom = -70;
      pading = 0;
    }
    if (botttom >= 0) {
      botttom = 0;
      pading = 64;
    }

    _last = current;
    if (botttom <= 0 && botttom >= -70) {
      emit(state.copyWith(bottom: botttom, padding: pading));
    }
  }
  // emit(state.copyWith(show: event.show));
}
