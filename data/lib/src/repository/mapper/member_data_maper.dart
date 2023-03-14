import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class MemberDataMapper extends BaseDataMapper<Data2ListMemberData, MemberDataEntry> {
  @override
  MemberDataEntry mapToEntity(Data2ListMemberData? data) {
    return MemberDataEntry(
    id:data?.id??-1,
   name:data?.name??'',
   email:data?.email??'',
   gender:data?.gender??'',
   dob:data?.dob??'',
   about:data?.about??'',
   avatar:data?.avatar,
   facebookUsername:data?.facebookUsername??'',
   telegramUsername:data?.telegramUsername??'',
   position:data?.position??'',
   department:data?.department??'',
    );
  }
}
