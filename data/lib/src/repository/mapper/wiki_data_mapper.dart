import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class WikitDataMapper extends BaseDataMapper<WikiModelData2, DataWiki> {
  @override
  DataWiki mapToEntity(WikiModelData2? data) {
    return DataWiki(
      slug: data?.slug,
      title: data?.title ?? '',
      createdAt: data?.createdAt,
      isRead: data?.isRead ?? 0,
      updatedAt: data?.updatedAt,
      publishedAt: data?.updatedAt,
    );
  }
}
