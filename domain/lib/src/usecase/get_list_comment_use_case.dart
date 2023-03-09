import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_list_comment_use_case.freezed.dart';

@Injectable()
class GetComentUseCase extends BaseFutureResUseCase<GetComentUseCaseInput, List<ComentDataEntry>> {
  GetComentUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<List<ComentDataEntry>> buildUseCase(GetComentUseCaseInput input) {
    return _repository.getComents(slungs: input.slungs);
  }
}

@freezed
class GetComentUseCaseInput extends BaseInput with _$GetComentUseCaseInput {
  const factory GetComentUseCaseInput({
    required String slungs,
  }) = _GetComentUseCaseInput;
}
