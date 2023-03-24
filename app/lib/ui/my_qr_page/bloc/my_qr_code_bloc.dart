import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class MyQrCodeBloc extends BaseBloc<MyQrCodeEvent, MyQrCodeState> {
  MyQrCodeBloc() : super(const MyQrCodeState()) {
    on<MyQrPageInitiated>(
      _onMainPageInitiated,
      transformer: log(),
    );
  }

  FutureOr<void> _onMainPageInitiated(MyQrPageInitiated event, Emitter<MyQrCodeState> emit) async {
    appBloc.add(const AppInitiated(handleErr: true));
  }
}
