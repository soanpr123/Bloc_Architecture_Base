import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/announcement_detail_data.dart';

import 'base/base_data_mapper.dart';

@Injectable()
class AnnouncementDataMapper extends BaseDataMapper<AnnouncementDetailData, AnnouncementDetail> {
  @override
  AnnouncementDetail mapToEntity(AnnouncementDetailData? data) {
    return AnnouncementDetail(
      title: data?.title,
      slug: data?.slug,
      content: data?.content,
      thumb: data?.thumb,
      url: data?.url,
      createdAt: data?.createdAt,
      updatedAt: data?.updatedAt,
    );
  }
}
