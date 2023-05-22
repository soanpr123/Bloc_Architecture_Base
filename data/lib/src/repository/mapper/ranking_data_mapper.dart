import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class RankingDataMapper extends BaseDataMapper<RankingData, RankingDataEntry> {
  @override
  RankingDataEntry mapToEntity(RankingData? data) {
    return RankingDataEntry(
        id: data?.id ?? -1,
        name: data?.name ?? '',
        avatar: data?.avatar ?? '',
        totalLikes: data?.totalLikes ?? 0,
        direction: data?.direction ?? 0,);
  }
}
