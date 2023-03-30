import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';
import '../model/pop_up_donate.dart';

@Injectable()
class PopUpDonateMapper extends BaseDataMapper<PopUpDonateData, PopUpDonateEntry> {
  @override
  PopUpDonateEntry mapToEntity(PopUpDonateData? data) {
    return PopUpDonateEntry(
      donor: data?.donor ?? '',
      amountAmais: data?.amountAmais ?? 0,
      note: data?.note ?? '',
    );
  }
}
