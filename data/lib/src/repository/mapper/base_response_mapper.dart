import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class BaseResponseDataMapper extends BaseDataMapper<DataResponse<dynamic>, BaseEntryData> {
  @override
  BaseEntryData mapToEntity(DataResponse<dynamic>? data) {
    return BaseEntryData(
      data: data?.data,
    );
  }
}
