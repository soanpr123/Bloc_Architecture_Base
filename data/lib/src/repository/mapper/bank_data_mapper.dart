import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/profile_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class BankDataMapper extends BaseDataMapper<BankData, Bank> {
  @override
  Bank mapToEntity(BankData? data) {
    return Bank(
      accountNumber: data?.accountNumber,
      bank: data?.bank,
      bankAgency: data?.bankAgency,
      name: data?.name,
      shortName: data?.shortName,
    );
  }
}
