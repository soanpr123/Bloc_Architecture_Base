import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../data.dart';
import '../model/history_amai_data.dart';

@Injectable()
class HistoryDataMapper extends BaseDataMapper<Data2HistoryAmai, HistoryAmai> {
  @override
  HistoryAmai mapToEntity(Data2HistoryAmai? data) {
    return HistoryAmai(
      id: data?.id??-1,
      amountAmais: data?.amountAmais??0,
      note: data?.note??'',
      createdAt: data?.createdAt,
      groub: ParseUtils.splitGroub(data?.createdAt??''),
    );
  }
}
