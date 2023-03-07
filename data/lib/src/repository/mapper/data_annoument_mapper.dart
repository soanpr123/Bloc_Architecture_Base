import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/announment_data.dart';

@Injectable()
class AnnounmentDataMapper extends BaseDataMapper<Data2Announment, DataAnnoument> {
  @override
  DataAnnoument mapToEntity(Data2Announment? data) {
    return DataAnnoument(
      slug: data?.slug,
      title: data?.title ?? '',
      createdAt: data?.createdAt,
      isRead: data?.isRead ?? 0,
    );
  }
}
