part of 'infomation_profile_cubit.dart';

class InfomationProfileState extends Equatable {
  final bool showEdit;
  final AppElevatedButtonState buttonState;
  const InfomationProfileState({this.showEdit = false, required this.buttonState});

  InfomationProfileState coppyWith({bool? showEdit, AppElevatedButtonState? buttonState}) {
    return InfomationProfileState(showEdit: showEdit ?? this.showEdit, buttonState: buttonState ?? this.buttonState);
  }

  @override
  List<Object> get props => [showEdit, buttonState];
}
