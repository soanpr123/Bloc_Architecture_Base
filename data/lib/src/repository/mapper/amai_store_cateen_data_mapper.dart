import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/amai_store_data.dart';

import 'base/base_data_mapper.dart';

@Injectable()
class AmaiCanteenMapper extends BaseDataMapper<Canteen, CanteenEntry> {
  @override
  CanteenEntry mapToEntity(Canteen? data) {
    return CanteenEntry(
      id: data?.id ?? -1,
      name: data?.name ?? '',
      orderNo: data?.orderNo ?? 0,
    );
  }
}
