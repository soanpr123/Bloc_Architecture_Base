import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

import 'tags_mapper.dart';

@Injectable()
class BlogsDataMapper extends BaseDataMapper<ListBlogsData2, BlogsDataEntry> {
  BlogsDataMapper(
    this._authorDataMapper,
  );

  final AuthorDataMapper _authorDataMapper;
  @override
  BlogsDataEntry mapToEntity(ListBlogsData2? data) {
    return BlogsDataEntry(
      id: data?.id ?? -1,
      author: _authorDataMapper.mapToEntity(data?.author),
      title: data?.title ?? '',
      slug: data?.slug ?? '',
      thumb: data?.thumb ?? '',
      totalLikes: data?.totalLikes ?? 0,
      isLiked: data?.isLiked ?? 0,
      isMyPost: data?.isMyPost ?? false,
      createdAt: data?.createdAt,
    );
  }
}
