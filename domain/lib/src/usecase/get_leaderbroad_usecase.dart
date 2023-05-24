 import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';
import 'base/future/base_future_use_case_response.dart';

part 'get_leaderbroad_usecase.freezed.dart';

@Injectable()
class GetLeaderBroadUseCase extends BaseFutureResUseCase<GetLeaderBroadInput, List<RankingDataEntry>> {
  GetLeaderBroadUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<List<RankingDataEntry>> buildUseCase(GetLeaderBroadInput input) {
    return _repository.getLeaderboard(
     
    );
  }
}

@freezed
class GetLeaderBroadInput extends BaseInput with _$GetLeaderBroadInput {
  const factory GetLeaderBroadInput() = _GetLeaderBroadInput;
}
