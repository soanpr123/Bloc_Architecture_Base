import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/amai_store_data.dart';

import 'amai_store_cateen_data_mapper.dart';
import 'base/base_data_mapper.dart';
import 'other_store_mapper.dart';

@Injectable()
class AmaiListStoreMapper extends BaseDataMapper<AmaiStoreData, ListDataStoreEntry> {
  AmaiListStoreMapper(this._amaiCanteenMapper, this._amaiOtherMapper);
  final AmaiCanteenMapper _amaiCanteenMapper;
  final AmaiOtherMapper _amaiOtherMapper;
  @override
  ListDataStoreEntry mapToEntity(AmaiStoreData? data) {
    return ListDataStoreEntry(
      canteen: _amaiCanteenMapper.mapToListEntity(data?.canteen ?? []),
      other: _amaiOtherMapper.mapToListEntity(data?.other ?? []),
    );
  }
}
