//This page contains the qr_code scanner which send *** when an qr_code is scanned

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

import '../../../../constants.dart';

class CustomSendQrScanner extends StatefulWidget {
  const CustomSendQrScanner({Key? key}) : super(key: key);

  @override
  State<CustomSendQrScanner> createState() => _CustomSendQrScannerState();
}

class _CustomSendQrScannerState extends State<CustomSendQrScanner> {
  final GlobalKey qrKey = GlobalKey();

  Barcode? barcode;
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        controller = controller;
        controller.scannedDataStream.listen((Barcode barcode) {
          controller.stopCamera();
          Navigator.of(context).pop(barcode.code);
        });
      },
      overlay: QrScannerOverlayShape(
        borderWidth: 10,
        cutOutSize: width * 0.7,
        cutOutBottomOffset: 10,
        borderColor: kAppColor,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) async {
      setState(() {
        this.barcode = barcode;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
