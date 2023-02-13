part of 'amai_store_cubit.dart';

class AmaiStoreState extends Equatable {
  final APIRequestStatus apiRequestStatus;

  final List<Canteen> listCanteen;
  final List<Other> listOther;
  const AmaiStoreState({required this.listCanteen, required this.listOther, required this.apiRequestStatus});
  AmaiStoreState coppyWith({APIRequestStatus? apiRequestStatus, List<Canteen>? listCanteen, List<Other>? listOther}) {
    return AmaiStoreState(
        apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus,
        listCanteen: listCanteen ?? this.listCanteen,
        listOther: listOther ?? this.listOther);
  }

  @override
  List<Object> get props => [apiRequestStatus, listCanteen, listOther];
}
