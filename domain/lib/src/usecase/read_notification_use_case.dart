import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';


import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'read_notification_use_case.freezed.dart';

@Injectable()
class ReadNotificationUseCase extends BaseFutureResUseCase<ReadNotificationInput, BaseEntryData> {
  ReadNotificationUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<BaseEntryData> buildUseCase(ReadNotificationInput input) {
    return _repository.readNotification(input.id);
  }
}

@freezed
class ReadNotificationInput extends BaseInput with _$ReadNotificationInput {
  const factory ReadNotificationInput({required String id}) = _ReadNotificationInput;
}
