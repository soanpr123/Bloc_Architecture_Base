import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_state.dart';
import '../../../shared_view/body_builder.dart';

part 'list_blogs_state.freezed.dart';

@freezed
class ListBlogsState extends BaseBlocState with _$ListBlogsState {
  const factory ListBlogsState({
    @Default(LoadMoreOutput<BlogsDataEntry>(data: <BlogsDataEntry>[]))
        LoadMoreOutput<BlogsDataEntry> blogs,
    @Default(<CategoryPostEntry>[])
        List<CategoryPostEntry> category,
    @Default(APIRequestStatus.loading)
        APIRequestStatus loading,
    AppException? loadUsersException,
    @Default(0)
        int curentTab,
    @Default(true)
        bool allPost,
    @Default(false)
        bool newPost,
    @Default('published_at')
        String orders,
    @Default('')
        String search,
    @Default(CategoryPostEntry(
      name: 'Tất cả',
      id: -1,
      slug: '',
    ))
        CategoryPostEntry categorySelect,
  }) = _ListBlogsState;
}
