import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class AnouncementDetailBloc extends BaseBloc<AnouncementDetailEvent, AnouncementDetailState> {
  AnouncementDetailBloc(this._announcementDetailUseCase, this._annoumentUseCase)
      : super(const AnouncementDetailState()) {
    on<AnouncementPageInitiated>(
      _onAnnouncementPageInitiated,
      transformer: log(),
    );
      on<AnouncementPageShowBack>(
      _onAnnouncementShow,
      transformer: log(),
    );
  }

  final AnnouncementDetailUseCase _announcementDetailUseCase;
  final ReadAnnoumentUseCase _annoumentUseCase;
  FutureOr<void> _onAnnouncementPageInitiated(
    AnouncementPageInitiated event,
    Emitter<AnouncementDetailState> emit,
  ) async {
    await runBlocCatching(
      action: () async {
        await _annoumentUseCase.execute(ReadAnnoumentInput(id: event.slungs));
        final output = await _announcementDetailUseCase.execute(AnnouncementDetailInput(slungs: event.slungs));
        emit(state.copyWith(announcementDetail: output));
      },
      handleLoading: true,
    );
  }

   FutureOr<void> _onAnnouncementShow(
    AnouncementPageShowBack event,
    Emitter<AnouncementDetailState> emit,
  ) async {
      emit(state.copyWith(show: event.show));
  }
}
