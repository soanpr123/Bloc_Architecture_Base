import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'home_event.dart';
import 'home_state.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._getUsersUseCase) : super(const HomeState()) {
    on<HomePageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }
  final GetMeUseCase _getUsersUseCase;
  FutureOr<void> _onMainPageInitiated(HomePageInitiated event, Emitter<HomeState> emit) async {}
}
