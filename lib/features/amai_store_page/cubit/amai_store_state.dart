part of 'amai_store_cubit.dart';

class AmaiStoreState extends Equatable {
  final APIRequestStatus apiRequestStatus;

  final AppElevatedButtonState buttonState;
  final List<Canteen> listCanteen;
  final List<Other> listOther;
  final DataOrdered ordered;
  const AmaiStoreState({
    required this.listCanteen,
    required this.listOther,
    required this.apiRequestStatus,
    required this.buttonState,
    required this.ordered,
  });
  AmaiStoreState coppyWith(
      {AppElevatedButtonState? buttonState,
      APIRequestStatus? apiRequestStatus,
      List<Canteen>? listCanteen,
      List<Other>? listOther,
      DataOrdered? ordered}) {
    return AmaiStoreState(
        buttonState: buttonState ?? this.buttonState,
        apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus,
        listCanteen: listCanteen ?? this.listCanteen,
        listOther: listOther ?? this.listOther,
        ordered: ordered ?? this.ordered);
  }

  @override
  List<Object> get props => [apiRequestStatus, listCanteen, listOther, buttonState, ordered];
}
