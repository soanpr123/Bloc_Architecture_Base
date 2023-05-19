import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'home_event.dart';
import 'home_state.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomePageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }
  FutureOr<void> _onMainPageInitiated(HomePageInitiated event, Emitter<HomeState> emit) async {}
}
