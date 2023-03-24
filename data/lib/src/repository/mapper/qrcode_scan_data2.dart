import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';


@Injectable()
class QrcodeScanData2Mapper extends BaseDataMapper<QrCodeDataData2, QrcodeScanData2Entry> {
  @override
  QrcodeScanData2Entry mapToEntity(QrCodeDataData2? data) {
    return QrcodeScanData2Entry(
      receiveUserId: data?.receiveUserId ?? -1,
      amountAmais: data?.amountAmais ?? 0,
      receiveUserName: data?.receiveUserName ?? '',
    );
  }
}
