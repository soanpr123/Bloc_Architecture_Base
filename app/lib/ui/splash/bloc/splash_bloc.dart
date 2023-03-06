import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'splash_event.dart';
import 'splash_state.dart';

@Injectable()
class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc(this._getInitialAppDataUseCase) : super(const SplashState()) {
    on<SplashInitiated>(
      _onAppInitiated,
      transformer: log(),
    );
  }

  final GetInitialAppDataUseCase _getInitialAppDataUseCase;

  Future<void> _onAppInitiated(SplashInitiated event, Emitter<SplashState> emit) async {
    await runBlocCatching(
      action: () async {
        final output = _getInitialAppDataUseCase.execute(const GetInitialAppDataInput());

        emit(state.copyWith(
          isLoggedIn: output.isLoggedIn,
        ));
        await Future<void>.delayed(const Duration(seconds: 2));
        await navigator.replace(const AppRouteInfo.main());
      },
      handleLoading: false,
    );
  }
}
