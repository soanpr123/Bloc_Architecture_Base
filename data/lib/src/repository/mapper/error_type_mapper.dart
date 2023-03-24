import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class ErrorTypeDataMapper extends BaseDataMapper<ErrorTypes, ErrorTypeEntry> {
  @override
  ErrorTypeEntry mapToEntity(ErrorTypes? data) {
    return ErrorTypeEntry(
      id: data?.id ?? -1,
      name: data?.name ?? '',
    );
  }
}
