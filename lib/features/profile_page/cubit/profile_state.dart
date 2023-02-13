part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final DataProfile profile;
  final bool showEditName;
  final AppElevatedButtonState buttonState;
  final AppElevatedButtonState requestLogout;
  final APIRequestStatus apiRequestStatus;
  final String pathAvata;

  const ProfileState({
    required this.profile,
    this.showEditName = false,
    required this.buttonState,
    required this.requestLogout,
    this.pathAvata = "",
    required this.apiRequestStatus,
  });

  ProfileState coppyWith(
      {DataProfile? profile,
      bool? showEditName,
      AppElevatedButtonState? buttonState,
      AppElevatedButtonState? requestLogout,
      String? pathAvata,
      APIRequestStatus? apiRequestStatus}) {
    return ProfileState(
        profile: profile ?? this.profile,
        showEditName: showEditName ?? this.showEditName,
        buttonState: buttonState ?? this.buttonState,
        requestLogout: requestLogout ?? this.requestLogout,
        pathAvata: pathAvata ?? this.pathAvata,
        apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus);
  }

  @override
  List<Object> get props => [profile, showEditName, buttonState, requestLogout, pathAvata, apiRequestStatus];
}

// class ProfileInitial extends ProfileState {}
