import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/amai_store_data.dart';

import 'base/base_data_mapper.dart';

@Injectable()
class AmaiOtherMapper extends BaseDataMapper<Other, OtherStoreEntry> {
  @override
  OtherStoreEntry mapToEntity(Other? data) {
    return OtherStoreEntry(
      id: data?.id ?? -1,
      name: data?.name ?? '',
      orderNo: data?.orderNo ?? 0,
    );
  }
}
