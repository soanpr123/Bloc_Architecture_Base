import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

import 'main_event.dart';
import 'main_state.dart';

@Injectable()
class MainBloc extends BaseBloc<MainEvent, MainState> {
  MainBloc(this._getUsersUseCase, this._totalNotificationUseCase) : super(const MainState()) {
    on<MainPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }
  final GetMeUseCase _getUsersUseCase;
  final GetTotalNotificationUseCase _totalNotificationUseCase;
  FutureOr<void> _onMainPageInitiated(MainPageInitiated event, Emitter<MainState> emit) async {
   
  }
}
