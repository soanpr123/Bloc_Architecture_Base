import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'read_annoumenr_usecase.freezed.dart';

@Injectable()
class ReadAnnoumentUseCase extends BaseFutureResUseCase<ReadAnnoumentInput, BaseEntryData> {
  ReadAnnoumentUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(ReadAnnoumentInput input) {
    return _repository.checkUserRead(slungs: input.id);
  }
}

@freezed
class ReadAnnoumentInput extends BaseInput with _$ReadAnnoumentInput {
  const factory ReadAnnoumentInput({required String id}) = _ReadAnnoumentInput;
}
