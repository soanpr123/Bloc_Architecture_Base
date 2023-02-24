import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/profile_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class IncognitoDataMapper extends BaseDataMapper<IncognitoData, Incognito> {
  @override
  Incognito mapToEntity(IncognitoData? data) {
    return Incognito(
      id: data?.id,
      name: data?.name,
      avatar: data?.avatar,
      about: data?.about,
    );
  }
}
