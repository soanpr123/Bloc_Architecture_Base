import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../data.dart';

@Injectable()
class ListMemberDataMapper extends BaseDataMapper<ListMemberData, ListDataMemberEntry> {
  ListMemberDataMapper(
    this._memberDataEntry,
  );

  final MemberDataMapper _memberDataEntry;
  @override
  ListDataMemberEntry mapToEntity(ListMemberData? data) {
    return ListDataMemberEntry(
      memmber: _memberDataEntry.mapToListEntity(data?.data),
      currentPage: data?.currentPage ?? -1,
      perPage: data?.perPage ?? -1,
      totalPage: data?.total ?? -1,
    );
  }
}
