part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final DataProfile profile;
  final bool showEditName;
  final AppElevatedButtonState buttonState;
  final AppElevatedButtonState requestLogout;
  const ProfileState(
      {required this.profile, this.showEditName = false, required this.buttonState, required this.requestLogout});

  ProfileState coppyWith(
      {DataProfile? profile,
      bool? showEditName,
      AppElevatedButtonState? buttonState,
      AppElevatedButtonState? requestLogout}) {
    return ProfileState(
      profile: profile ?? this.profile,
      showEditName: showEditName ?? this.showEditName,
      buttonState: buttonState ?? this.buttonState,
      requestLogout: requestLogout ?? this.requestLogout,
    );
  }

  @override
  List<Object> get props => [profile, showEditName, buttonState, requestLogout];
}

// class ProfileInitial extends ProfileState {}
