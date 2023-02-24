import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/preference_user_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class PreferenceUserDataMapper extends BaseDataMapper<PreferenceUserData, Profile> with DataMapperMixin {
  @override
  Profile mapToEntity(PreferenceUserData? data) {
    return Profile(
      id: data?.id ?? -1,
      email: data?.email ?? '',
    );
  }

  @override
  PreferenceUserData mapToData(Profile entity) {
    return PreferenceUserData(
      id: entity.id ?? -1,
      email: entity.email ?? '',
    );
  }
}
