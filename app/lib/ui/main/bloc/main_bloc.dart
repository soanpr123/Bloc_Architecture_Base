import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

import 'main_event.dart';
import 'main_state.dart';

@Injectable()
class MainBloc extends BaseBloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }
  FutureOr<void> _onMainPageInitiated(MainPageInitiated event, Emitter<MainState> emit) async {
    appBloc.add(const AppInitiated(handleErr: true));
  }
}
