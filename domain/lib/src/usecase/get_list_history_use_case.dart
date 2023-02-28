import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_list_history_use_case.freezed.dart';

@Injectable()
class GetHistoryUseCase extends BaseFutureResUseCase<GetHistoryUseCaseInput, List<HistoryAmai>> {
  GetHistoryUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<List<HistoryAmai>> buildUseCase(GetHistoryUseCaseInput input) {
    return _repository.getHistory(
      page: input.page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetHistoryUseCaseInput extends BaseInput with _$GetHistoryUseCaseInput {
  const factory GetHistoryUseCaseInput({
    @Default(1) int page,
  }) = _GetHistoryUseCaseInput;
}
