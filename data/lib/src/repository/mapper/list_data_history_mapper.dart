import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/history_amai_data.dart';
import 'data_history_mapper.dart';

@Injectable()
class HistoryListDataMapper extends BaseDataMapper<HistoryAmaiData, HistoryAmaiList> {
  HistoryListDataMapper(
    this._notificationDataMapper,
  );

  final HistoryDataMapper _notificationDataMapper;
  @override
  HistoryAmaiList mapToEntity(HistoryAmaiData? data) {
    return HistoryAmaiList(
      notification: _notificationDataMapper.mapToListEntity(data?.data ?? []),
      perPage: data?.perPage ?? -1,
      currentPage: data?.currentPage ?? -1,
      total: data?.total ?? -1,
      totalPage: data?.totalPage ?? -1,
    );
  }
}
