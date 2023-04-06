import 'dart:async';

import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_event.dart';

part 'list_blogs_event.freezed.dart';

abstract class ListBlogsEvent extends BaseBlocEvent {
  const ListBlogsEvent();
}

@freezed
class ListBlogsPageInitiated extends ListBlogsEvent with _$ListBlogsPageInitiated {
  const factory ListBlogsPageInitiated({
    @Default(true) bool isIntinalLoad,
    @Default('') String tag,
  }) = _ListBlogsPageInitiated;
}

@freezed
class ListBlogsPageRefreshed extends ListBlogsEvent with _$ListBlogsPageRefreshed {
  const factory ListBlogsPageRefreshed({
    required Completer<void> completer,
  }) = _ListBlogsPageRefreshed;
}

@freezed
class ListBlogsLoadMore extends ListBlogsEvent with _$ListBlogsLoadMore {
  const factory ListBlogsLoadMore() = _ListBlogsLoadMore;
}

@freezed
class PressTab extends ListBlogsEvent with _$PressTab {
  const factory PressTab({
    @Default(0) int postType,
  }) = _PressTab;
}

@freezed
class ListBlogsStatusSelect extends ListBlogsEvent with _$ListBlogsStatusSelect {
  const factory ListBlogsStatusSelect({
    @Default(true) bool allPost,
    @Default(false) bool newPost,
  }) = _ListBlogsStatusSelect;
}

@freezed
class ListBlogsCateSelect extends ListBlogsEvent with _$ListBlogsCateSelect {
  const factory ListBlogsCateSelect({
    @Default(CategoryPostEntry(
      name: 'Tất cả',
      id: -1,
      slug: '',
    ))
        CategoryPostEntry categorySelect,
  }) = _ListBlogsCateSelect;
}

@freezed
class ListBlogsSearch extends ListBlogsEvent with _$ListBlogsSearch {
  const factory ListBlogsSearch({
    @Default('') String search,
  }) = _ListBlogsSearch;
}

@freezed
class FillterButtonPress extends ListBlogsEvent with _$FillterButtonPress {
  const factory FillterButtonPress() = _FillterButtonPress;
}

@freezed
class ResetsFillterButtonPress extends ListBlogsEvent with _$ResetsFillterButtonPress {
  const factory ResetsFillterButtonPress() = _ResetsFillterButtonPress;
}
