part of 'qr_code_page_cubit.dart';

class QrCodePageState extends Equatable {
  String result;
  QrCodePageState({this.result = ""});

  QrCodePageState addState({String? result}) {
    return QrCodePageState(result: result ?? this.result);
  }

  @override
  List<Object> get props => [result];
}
