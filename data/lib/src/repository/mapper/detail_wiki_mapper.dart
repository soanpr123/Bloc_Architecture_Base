import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class WikiDetailDataMapper extends BaseDataMapper<WikiDetailData, WikiDetail> {
  @override
  WikiDetail mapToEntity(WikiDetailData? data) {
    return WikiDetail(
      title: data?.title,
      slug: data?.slug,
      content: data?.content,
      thumb: data?.thumb,
      url: data?.url,
      createdAt: data?.createdAt,
      updatedAt: data?.updatedAt,
      publishedAt: data?.publishedAt,
    );
  }
}
