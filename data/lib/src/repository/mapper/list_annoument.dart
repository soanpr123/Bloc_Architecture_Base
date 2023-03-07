import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/announment_data.dart';
import 'data_annoument_mapper.dart';

@Injectable()
class AnnounmentListDataMapper extends BaseDataMapper<AnnounmentData, ListAnnoument> {
  AnnounmentListDataMapper(
    this._announmentDataMapper,
  );

  final AnnounmentDataMapper _announmentDataMapper;
  @override
  ListAnnoument mapToEntity(AnnounmentData? data) {
    return ListAnnoument(
      notification: _announmentDataMapper.mapToListEntity(data?.data),
      perPage: data?.perPage ?? -1,
      currentPage: data?.currentPage ?? -1,
      total: data?.total ?? -1,
      totalPage: data?.totalPage ?? -1,
    );
  }
}
