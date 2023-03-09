import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_list_wiki.freezed.dart';

@Injectable()
class GetWikiUseCase extends BaseLoadMoreUseCase<GetWikiInput, DataWiki> {
  GetWikiUseCase(this._repository) : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<DataWiki>> buildUseCase(GetWikiInput input) {
    return _repository.getWiki(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetWikiInput extends BaseInput with _$GetWikiInput {
  const factory GetWikiInput() = _GetWikiInput;
}
