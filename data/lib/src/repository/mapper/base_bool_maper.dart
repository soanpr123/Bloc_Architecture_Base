import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class BaseBoolDataMapper extends BaseDataMapper<DataResponse<dynamic>, BaseBoolData> {
  @override
  BaseBoolData mapToEntity(DataResponse<dynamic>? data) {
    return BaseBoolData(
      data: data?.data,
    );
  }
}
