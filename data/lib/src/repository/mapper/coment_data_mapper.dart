import 'package:data/src/repository/mapper/reppy_comment_mapper.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class CommentDataMapper extends BaseDataMapper<ComentDataModel, ComentDataEntry> {
  CommentDataMapper(this._comentDataEntry);
  final ReppyComentMapper _comentDataEntry;
  @override
  ComentDataEntry mapToEntity(ComentDataModel? data) {
    return ComentDataEntry(
      id: data?.id ?? -1,
      name: data?.name ?? '',
      avatar: data?.avatar ?? '',
      content: data?.content ?? '',
      isOwner: data?.isOwner ?? 0,
      isLiked: data?.isLiked ?? 0,
      totalLikes: data?.totalLikes ?? 0,
      replyUserName: data?.replyUserName ?? '',
      createdAt: data?.createdAt ?? '',
      updatedAt: data?.updatedAt ?? '',
      reply: _comentDataEntry.mapToListEntity(data?.reply ?? []),
    );
  }
}
