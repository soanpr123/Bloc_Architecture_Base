import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

@Injectable()
class ListBlogsBloc extends BaseBloc<ListBlogsEvent, ListBlogsState> {
  ListBlogsBloc(this._getListBlogsCase, this._getResourceUseCase) : super(ListBlogsState()) {
    on<ListBlogsPageInitiated>(
      _onListBlogsPageInitiated,
      transformer: log(),
    );

    on<ListBlogsLoadMore>(
      _onBlogsLoadMore,
      transformer: log(),
    );
    on<ListBlogsPageRefreshed>(
      _onBlogsRefreshed,
      transformer: log(),
    );
    on<ListBlogsStatusSelect>(
      _onStatusSelect,
      transformer: log(),
    );
    on<ListBlogsCateSelect>(
      _onBlogsCateSelect,
      transformer: log(),
    );

    on<FillterButtonPress>(
      _onFillterPress,
      transformer: log(),
    );
    on<ResetsFillterButtonPress>(
      _onResetFillterPress,
      transformer: log(),
    );
    on<PressTab>(
      _onPressTab,
      transformer: log(),
    );
    on<ListBlogsSearch>(
      _onSearchBlogs,
      transformer: log(),
    );
  }
  final GetListBlogsCase _getListBlogsCase;
  final GetResourceUseCase _getResourceUseCase;
  final List<CategoryPostEntry> listCate = [];
  FutureOr<void> _onListBlogsPageInitiated(ListBlogsPageInitiated event, Emitter<ListBlogsState> emit) async {
    listCate.clear();
    listCate.add(const CategoryPostEntry(
      name: 'Tất cả',
      id: -1,
      slug: '',
    ));
    await getListBlogs(
      postType: state.curentTab,
      orderKey: state.orders,
      search: state.search,
      cateSlung: state.categorySelect.slug ?? '',
      emit: emit,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(
        state.copyWith(
          loading: event.isIntinalLoad ? APIRequestStatus.loading : APIRequestStatus.loaded,
        ),
      ),
    );

    await getCategory(emit: emit);
  }

  FutureOr<void> _onBlogsLoadMore(ListBlogsLoadMore event, Emitter<ListBlogsState> emit) async {
    await getListBlogs(
      postType: state.curentTab,
      orderKey: state.orders,
      search: state.search,
      cateSlung: state.categorySelect.slug ?? '',
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onStatusSelect(ListBlogsStatusSelect event, Emitter<ListBlogsState> emit) async {
    emit(state.copyWith(allPost: event.allPost, newPost: event.newPost));

    if (event.allPost) {
      emit(state.copyWith(allPost: event.allPost, newPost: event.newPost, orders: 'published_at'));
    } else {
      emit(state.copyWith(allPost: event.allPost, newPost: event.newPost, orders: 'total_likes'));
    }
  }

  FutureOr<void> _onSearchBlogs(ListBlogsSearch event, Emitter<ListBlogsState> emit) async {
    await getListBlogs(
      postType: state.curentTab,
      orderKey: state.orders,
      cateSlung: state.categorySelect.slug ?? '',
      emit: emit,
      isInitialLoad: true,
      search: event.search,
      doOnSubscribe: () async => emit(
        state.copyWith(
          search: event.search,
          loading: APIRequestStatus.loading,
        ),
      ),
    );
  }

  FutureOr<void> _onBlogsCateSelect(ListBlogsCateSelect event, Emitter<ListBlogsState> emit) async {
    emit(state.copyWith(categorySelect: event.categorySelect));
  }

  FutureOr<void> _onPressTab(PressTab event, Emitter<ListBlogsState> emit) async {
    await getListBlogs(
      postType: event.postType,
      orderKey: state.orders,
      cateSlung: state.categorySelect.slug ?? '',
      emit: emit,
      search: state.search,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(
        state.copyWith(
          curentTab: event.postType,
          loading: APIRequestStatus.loading,
        ),
      ),
    );
    // await getCategory(emit: emit);
  }

  FutureOr<void> _onFillterPress(FillterButtonPress event, Emitter<ListBlogsState> emit) async {
    await getListBlogs(
      postType: state.curentTab,
      orderKey: state.orders,
      cateSlung: state.categorySelect.slug ?? '',
      emit: emit,
      search: state.search,
      isInitialLoad: true,
      doOnSubscribe: () async => emit(
        state.copyWith(
          loading: APIRequestStatus.loading,
        ),
      ),
    );
  }

  FutureOr<void> _onResetFillterPress(ResetsFillterButtonPress event, Emitter<ListBlogsState> emit) async {
    emit(
      state.copyWith(
        allPost: true,
        newPost: false,
        orders: 'published_at',
        categorySelect: const CategoryPostEntry(
          name: 'Tất cả',
          id: -1,
          slug: '',
        ),
      ),
    );
  }

  FutureOr<void> _onBlogsRefreshed(ListBlogsPageRefreshed event, Emitter<ListBlogsState> emit) async {
    await getListBlogs(
      postType: state.curentTab,
      orderKey: state.orders,
      cateSlung: state.categorySelect.slug ?? '',
      emit: emit,
      search: state.search,
      isInitialLoad: true,
      doOnSubscribe: () async {
        emit(state.copyWith(
          loading: APIRequestStatus.loading,
        ));
      },
      doOnSuccessOrError: () async {
        if (!event.completer.isCompleted) {
          event.completer.complete();
        }
      },
    );
  }

  Future<void> getListBlogs({
    required Emitter<ListBlogsState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    required int postType,
    required String orderKey,
    required String cateSlung,
    required String search,
  }) async {
    return runBlocCatching(
      action: () async {
        final out = await _getListBlogsCase.execute(
          GetListBlogsInput(postType: postType, orderKey: orderKey, categorySlug: cateSlung, search: search),
          isInitialLoad,
        );

        if (out.data.isNotEmpty) {
          emit(state.copyWith(blogs: out, loading: APIRequestStatus.loaded));
        } else {
          emit(state.copyWith(blogs: out, loading: APIRequestStatus.nodata));
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              loadUsersException: e,
              loading: APIRequestStatus.connectionError,
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

  Future<void> getCategory({
    required Emitter<ListBlogsState> emit,
  }) async {
    return runBlocCatching(
      action: () async {
        final out = await _getResourceUseCase.execute(const GetResourceInput(type: 'category_posts'));
        if (out.category != null && out.category!.isNotEmpty) {
          listCate.addAll(out.category!);
          emit(state.copyWith(
            category: listCate,
          ));
        } else {
          emit(state.copyWith(
            category: listCate,
          ));
        }
      },
      doOnError: (e) async {
        if (e.appExceptionType == AppExceptionType.remote) {
          final exception = e as RemoteException;

          if (exception.kind == RemoteExceptionKind.noInternet || exception.kind == RemoteExceptionKind.network) {
            emit(state.copyWith(
              loadUsersException: e,
              loading: APIRequestStatus.connectionError,
            ));
          }
        } else {
          emit(state.copyWith(
            loadUsersException: e,
          ));
        }
      },
      handleLoading: false,
      handleError: false,
    );
  }
}
