import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_list_annoument_data.freezed.dart';

@Injectable()
class GetAnnoumentnUseCase extends BaseLoadMoreUseCase<GetAnnoumentInput, DataAnnoument> {
  GetAnnoumentnUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<DataAnnoument>> buildUseCase(GetAnnoumentInput input) {
    return _repository.getAnnounment(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetAnnoumentInput extends BaseInput with _$GetAnnoumentInput {
  const factory GetAnnoumentInput() = _GetAnnoumentInput;
}
