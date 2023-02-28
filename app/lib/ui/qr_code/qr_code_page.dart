import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends BasePageState<QrCodePage, QrCodeBloc> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool shownPermissionDenied = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: BlocBuilder<QrCodeBloc, QrCodeState>(
        buildWhen: (previous, current) => previous.cameraPermission != current.cameraPermission,
        builder: (context, state) {
          return Stack(
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: (controller) {
                  this.controller = controller;
                  bloc.add(QrcodePageInitiated(controller: this.controller!));
                },
                overlay: QrScannerOverlayShape(
                  overlayColor: colorGray800.withOpacity(0.95),
                  borderColor: colorBrandPrimary,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
                onPermissionSet: (p0, p1) async {
                  controller = p0;
                  if (!shownPermissionDenied) {
                    await _onPermissionDenied(context, p0, p1);
                  }

                  return;
                  // Log.d(p1, name: 'Perrmision');
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
                  child: Text(
                    S.current.qr_title,
                    style: typoInterNomal18.copyWith(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 64),
                  child: GestureDetector(
                    onTap: () {
                      navigator.pop();
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: colorBrandPrimary, borderRadius: const BorderRadius.all(Radius.circular(30))),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
          // : SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'Bạn phải cấp quyền camera để sử dụng tính năng này',
          //             textAlign: TextAlign.center,
          //             style: typoInterNomal14.copyWith(color: colorTextMedium, fontWeight: FontWeight.w600),
          //           ),
          //           SizedBox(
          //             height: Dimens.d16.responsive(),
          //           ),
          //           Row(
          //             children: [
          //               Expanded(
          //                 child: AppElevatedButton(
          //                   mainColor: colorBrandSecondary,
          //                   buttonTitle: 'Hủy',
          //                   onPressed: () async {
          //                     await navigator.pop();
          //                   },
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: Dimens.d8.responsive(),
          //               ),
          //               Expanded(
          //                 child: AppElevatedButton(
          //                   buttonTitle: 'Đi tới cài đặt',
          //                   onPressed: () async {
          //                     await PermissionConstants.requestPermissionWithOpenSettings();
          //                     await navigator.pop();
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  Future<void> _onPermissionDenied(BuildContext context, QRViewController ctrl, bool p) async {
    if (!p) {
      await navigator.showDialog(AppPopupInfo.confirm(
        message: S.current.tell_me_permission,
        confirm: Func0(() async {
          // bloc.add(const LogOutRequest());
          await navigator.pop();
          await PermissionConstants.requestPermissionWithOpenSettings();
        }),
      ));
    }

    shownPermissionDenied = true;
  }
}
