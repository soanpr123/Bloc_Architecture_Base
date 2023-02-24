import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';


import '../model/profile_data.dart';
import 'base/base_data_mapper.dart';

@Injectable()
class SocialsDataMapper extends BaseDataMapper<SocialsData, Socials> {
  @override
  Socials mapToEntity(SocialsData? data) {
    return Socials(
      facebookUrl: data?.facebookUrl,
      facebookUsername: data?.facebookUsername,
      telegramUrl: data?.telegramUrl,
      telegramUsername: data?.telegramUsername,
    );
  }
}
