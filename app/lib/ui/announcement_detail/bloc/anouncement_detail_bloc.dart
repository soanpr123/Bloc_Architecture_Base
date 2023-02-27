import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class AnouncementDetailBloc extends BaseBloc<AnouncementDetailEvent, AnouncementDetailState> {
  AnouncementDetailBloc(this._announcementDetailUseCase) : super(const AnouncementDetailState()) {
    on<AnouncementPageInitiated>(
      _onAnnouncementPageInitiated,
      transformer: log(),
    );
  }

  final AnnouncementDetailUseCase _announcementDetailUseCase;

  FutureOr<void> _onAnnouncementPageInitiated(
    AnouncementPageInitiated event,
    Emitter<AnouncementDetailState> emit,
  ) async {
    await runBlocCatching(
      action: () async {
        final output = await _announcementDetailUseCase.execute(AnnouncementDetailInput(slungs: event.slungs));
        emit(state.copyWith(announcementDetail: output));
      },
      handleLoading: true,
    );
  }
}
