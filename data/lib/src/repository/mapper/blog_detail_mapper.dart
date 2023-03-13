import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/blogs_model_data.dart';
import 'tags_mapper.dart';

@Injectable()
class BlogsDetailDataMapper extends BaseDataMapper<BlogsModelData, BlogsDetailEntry> {
  BlogsDetailDataMapper(
    this._notificationDataMapper,
    this._authorDataMapper,
  );

  final TagsDataMapper _notificationDataMapper;
  final AuthorDataMapper _authorDataMapper;
  @override
  BlogsDetailEntry mapToEntity(BlogsModelData? data) {
    return BlogsDetailEntry(
      id: data?.id ?? -1,
      author: _authorDataMapper.mapToEntity(data?.author),
      categoryName: data?.categoryName,
      title: data?.title,
      slug: data?.slug,
      content: data?.content,
      url: data?.url,
      totalLikes: data?.totalLikes,
      totalViewed: data?.totalViewed,
      totalComments: data?.totalComments,
      totalAmais: data?.totalAmais,
      isLiked: data?.isLiked,
      isVotedAmai: data?.isVotedAmai,
      isMyPost: data?.isMyPost,
      status: data?.status,
      tags: _notificationDataMapper.mapToListEntity(data?.tags),
      createdAt: data?.createdAt,
    );
  }
}
