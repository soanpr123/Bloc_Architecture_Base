import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'read_all_notifi_use_case.freezed.dart';

@Injectable()
class ReadAllNotificationUseCase extends BaseFutureResUseCase<ReadAllNotificationInput, BaseEntryData> {
  ReadAllNotificationUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(ReadAllNotificationInput input) {
    return _repository.readAllNotification();
  }
}

@freezed
class ReadAllNotificationInput extends BaseInput with _$ReadAllNotificationInput {
  const factory ReadAllNotificationInput() = _ReadAllNotificationInput;
}
