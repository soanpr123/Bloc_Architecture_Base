import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_list_member_use_case.freezed.dart';

@Injectable()
class GetMemberUseCase extends BaseLoadMoreUseCase<GetMemberInput, MemberDataEntry> {
  GetMemberUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<MemberDataEntry>> buildUseCase(GetMemberInput input) {
    return _repository.getListMember(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetMemberInput extends BaseInput with _$GetMemberInput {
  const factory GetMemberInput() = _GetMemberInput;
}
