import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/component/app_elevated_button.dart';
import 'package:project/core/di/dependency_injection.dart';
import 'package:project/core/utils/toast_message.dart';
import 'package:project/features/internal_app/data/repository/internal_app_repository.dart';
import 'package:project/features/profile_page/cubit/profile_cubit.dart';

part 'infomation_profile_state.dart';

class InfomationProfileCubit extends Cubit<InfomationProfileState> {
  InfomationProfileCubit() : super(const InfomationProfileState(buttonState: AppElevatedButtonState.active));
  final responsitory = getIt.get<InternalAppRepository>();
  final blocProfile = getIt<ProfileCubit>();
  void showEdit(bool show) {
    emit(state.coppyWith(showEdit: show));
  }

  Future<void> updateMe(String name) async {
    final request = {"about": name, "avatar": blocProfile.state.profile.incognito?.avatar ?? ""};

    emit(state.coppyWith(buttonState: AppElevatedButtonState.loading));
    // await Future.delayed(const Duration(seconds: 2));
    try {
      final response = await responsitory.updateMe(request);
      if (response.data['status_code'] == 200) {
        await blocProfile.getProfile();
        successToast(response.data['message']);
        emit(state.coppyWith(showEdit: !state.showEdit, buttonState: AppElevatedButtonState.active));
      } else {
        errorToast(msg: response.data['message']);
      }
    } catch (e) {
      emit(state.coppyWith(buttonState: AppElevatedButtonState.active));
    }
  }
}
