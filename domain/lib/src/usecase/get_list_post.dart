import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_list_post.freezed.dart';

@Injectable()
class GetListBlogsCase extends BaseLoadMoreUseCase<GetListBlogsInput, BlogsDataEntry> {
  GetListBlogsCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<BlogsDataEntry>> buildUseCase(GetListBlogsInput input) {
    return _repository.getListPost(
      page: page,
      limit: PagingConstants.itemsPerPage,
      categorySlug: input.categorySlug,
      orderDir: input.orderDir,
      orderKey: input.orderKey,
      postType: input.postType,
      search: input.search,
    );
  }
}

@freezed
class GetListBlogsInput extends BaseInput with _$GetListBlogsInput {
  const factory GetListBlogsInput({
    @Default('') String categorySlug,
    @Default('published_at') String orderKey,
    @Default('desc') String orderDir,
    @Default(0) int postType,
    @Default('') String search,
  }) = _GetListBlogsInput;
}
