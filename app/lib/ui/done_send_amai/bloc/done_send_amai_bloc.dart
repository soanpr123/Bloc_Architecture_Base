import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class DoneSendAmaiBloc extends BaseBloc<DoneSendAmaiEvent, DoneSendAmaiState> {
  DoneSendAmaiBloc() : super(const DoneSendAmaiState()) {
    on<DoneSendPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }

  FutureOr<void> _onMainPageInitiated(DoneSendPageInitiated event, Emitter<DoneSendAmaiState> emit) async {
    appBloc.add(const AppInitiated(handleErr: true));
  }
}
