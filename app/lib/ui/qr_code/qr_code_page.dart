import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:resources/resources.dart';

import '../../app.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends BasePageState<QrCodePage, QrCodeBloc> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

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
      body: Stack(
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}
