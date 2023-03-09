import 'package:data/src/repository/mapper/wiki_data_mapper.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';


@Injectable()
class AnnounmentListDataMapper extends BaseDataMapper<WikiModelData, ListWikiData> {
  AnnounmentListDataMapper(
    this.wikitDataMapper,
  );

  final WikitDataMapper wikitDataMapper;
  @override
  ListWikiData mapToEntity(WikiModelData? data) {
    return ListWikiData(
      notification: wikitDataMapper.mapToListEntity(data?.data),
      perPage: data?.perPage ?? -1,
      currentPage: data?.currentPage ?? -1,
      total: data?.total ?? -1,
      totalPage: data?.totalPage ?? -1,
    );
  }
}
