import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class DonationRecipientDataMapper extends BaseDataMapper<DonationRecipient, DonationRecipientEntry> {
  @override
  DonationRecipientEntry mapToEntity(DonationRecipient? data) {
    return DonationRecipientEntry(
      id: data?.id ?? -1,
 
      name: data?.name ?? '',
    );
  }
}
