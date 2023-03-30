import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class QrcodeScanDataMapper extends BaseDataMapper<QrCodeData, QrcodeScanDataEntry> {
  QrcodeScanDataMapper(this._data2mapper);
  final QrcodeScanData2Mapper _data2mapper;
  @override
  QrcodeScanDataEntry mapToEntity(QrCodeData? data) {
    return QrcodeScanDataEntry(type: data?.type ?? 0, data: _data2mapper.mapToEntity(data?.data));
  }
}
