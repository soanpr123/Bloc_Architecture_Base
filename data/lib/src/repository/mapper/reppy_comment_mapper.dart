import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class ReppyComentMapper extends BaseDataMapper<Reply, ReppyComentDataEntry> {
  @override
  ReppyComentDataEntry mapToEntity(Reply? data) {
    return ReppyComentDataEntry(
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
      reply: data?.reply,
    );
  }
}
