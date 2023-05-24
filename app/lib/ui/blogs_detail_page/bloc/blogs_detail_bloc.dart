import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import '../../../utils/toast_message.dart';

@Injectable()
class BlogsDetailBloc extends BaseBloc<BlogsDetailEvent, BlogsDetailState> {
  BlogsDetailBloc(
    this._blogsDetailUseCase,
    this._comentUseCase,
    this._blogsUseCase,
    this._likeComentUseCase,
    this._sendAmaiUseCase,
    this._createCommentUseCase,
    this._createReppllyCommentInput,
  ) : super(const BlogsDetailState()) {
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
    on<CreateComment>(
      _createComment,
      transformer: log(),
    );
    on<SelectComent>(
      _selectCmt,
      transformer: log(),
    );
    on<DeleteSelectCmt>(
      _deleteselectCmt,
      transformer: log(),
    );
    on<RepplyComment>(
      _createRepplyComment,
      transformer: log(),
    );
    on<OnChangeCmt>(
      _onChangeCmt,
      transformer: log(),
    );
    on<ForcusComment>(
      _forcusComment,
      transformer: log(),
    );
  }

  final BlogsDetailUseCase _blogsDetailUseCase;
  final GetComentUseCase _comentUseCase;
  final LikeBlogsUseCase _blogsUseCase;
  final LikeComentUseCase _likeComentUseCase;
  final SendAmaiUseCase _sendAmaiUseCase;
  final CreateCommentUseCase _createCommentUseCase;
  final CreateRepplyCommentUseCase _createReppllyCommentInput;
  double _last = 0;

  FutureOr<void> _onMainPageInitiated(BlogsDetailPageInitiated event, Emitter<BlogsDetailState> emit) async {
    await getDetailBlogs(slungs: event.slungs, emit: emit);
  }

  FutureOr<void> _createComment(CreateComment event, Emitter<BlogsDetailState> emit) async {
    await createComment(slungs: event.slungs, comment: event.comment, emit: emit, event: event);
  }

  FutureOr<void> _createRepplyComment(RepplyComment event, Emitter<BlogsDetailState> emit) async {
    await createRepplyComment(id: event.id, slungs: event.slungs, comment: event.content, emit: emit, event: event);
  }

  FutureOr<void> _selectCmt(SelectComent event, Emitter<BlogsDetailState> emit) async {
    emit(state.copyWith(cmtSelect: event.id, name: event.name));
  }

  FutureOr<void> _forcusComment(ForcusComment event, Emitter<BlogsDetailState> emit) async {
    emit(state.copyWith(isComment: event.isComment));
  }

  FutureOr<void> _onChangeCmt(OnChangeCmt event, Emitter<BlogsDetailState> emit) async {
    if (event.cmt.isNotEmpty) {
      emit(state.copyWith(buttonSendState: AppElevatedButtonState.active));
    } else {
      emit(state.copyWith(buttonSendState: AppElevatedButtonState.inactive));
    }
  }

  FutureOr<void> _deleteselectCmt(DeleteSelectCmt event, Emitter<BlogsDetailState> emit) async {
    emit(state.copyWith(cmtSelect: -1));
  }

  Future<void> getDetailBlogs(
      {required String slungs, bool isLoading = false, required Emitter<BlogsDetailState> emit}) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        if (!isLoading) {
          emit(state.copyWith(apiRequestStatus: APIRequestStatus.loading));
        }
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
          output.sort(
            (a, b) => a.id!.compareTo(b.id!),
          );
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

  Future<void> createComment({
    required String slungs,
    required String comment,
    required Emitter<BlogsDetailState> emit,
    required CreateComment event,
  }) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(buttonSendState: AppElevatedButtonState.loading));
      },
      action: () async {
        final output = await _createCommentUseCase.execute(CreateCommentInput(slugs: slungs, comment: comment));
        if (output.data['status_code'] == 200) {
          // emit(state.copyWith(comment: output));
          event.textEdt.clear();
          emit(state.copyWith(buttonSendState: AppElevatedButtonState.inactive));
          await getDetailBlogs(slungs: slungs, isLoading: true, emit: emit);
          await getComment(slungs: slungs, emit: emit);
          await event.scrollController.animateTo(
            event.scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        } else {
          errorToast(msg: output.data['message']);
          emit(state.copyWith(buttonSendState: AppElevatedButtonState.inactive));
        }
      },
      handleLoading: false,
      handleError: false,
      doOnError: (e) async {
        emit(state.copyWith(buttonSendState: AppElevatedButtonState.active));
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

  Future<void> createRepplyComment({
    required String id,
    required String slungs,
    required String comment,
    required Emitter<BlogsDetailState> emit,
    required RepplyComment event,
  }) async {
    return runBlocCatching(
      doOnSubscribe: () async {
        emit(state.copyWith(buttonSendState: AppElevatedButtonState.loading));
      },
      action: () async {
        final output = await _createReppllyCommentInput
            .execute(CreateReppllyCommentInput(id: id, slugs: slungs, comment: comment));
        if (output.data['status_code'] == 200) {
          // emit(state.copyWith(comment: output));
          event.textEdt.clear();
          emit(state.copyWith(buttonSendState: AppElevatedButtonState.inactive));
          await getDetailBlogs(slungs: slungs, isLoading: true, emit: emit);
          await getComment(slungs: slungs, emit: emit);
        } else {
          errorToast(msg: output.data['message']);
          emit(state.copyWith(buttonSendState: AppElevatedButtonState.inactive));
        }
      },
      handleLoading: false,
      handleError: false,
      doOnError: (e) async {
        emit(state.copyWith(buttonSendState: AppElevatedButtonState.active));
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
          errorToast(msg: output.data['message'].toString());
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
      botttom = -75;
      pading = 0;
    }
    if (botttom >= 0) {
      botttom = 0;
      pading = 64;
    }

    _last = current;
    if (botttom <= 0 && botttom >= -75) {
      emit(state.copyWith(bottom: botttom, padding: pading));
    }
  }
  // emit(state.copyWith(show: event.show));
}
