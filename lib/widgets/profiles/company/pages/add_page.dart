import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../constants.dart';
import '../home.dart';

class QRScanWidget extends StatefulWidget {
  const QRScanWidget({Key? key, required this.ID}) : super(key: key);
  final String ID;

  @override
  State<StatefulWidget> createState() => _QRScanWidgetState();
}

class _QRScanWidgetState extends State<QRScanWidget> {
  final firestoreRef = FirebaseFirestore.instance;
  final GlobalKey qrKey = GlobalKey();
  Barcode? barcode;
  QRViewController? controller;
  final TextEditingController nameBinController = TextEditingController();

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
    double height = MediaQuery.of(context).size.height;

    final barCodeField = TextFormField(
      controller: nameBinController,
      onSaved: (value) {
        nameBinController.text = value!;
      },
      decoration: InputDecoration(
        hintText: 'Bar code',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kAppColor, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kAppColor, width: 2.0),
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.2),
              child: QRView(
                key: qrKey,
                onQRViewCreated: onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderWidth: 10,
                  cutOutSize: width * 0.8,
                  borderColor: kAppColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.85),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: barCodeField,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (nameBinController.text.isNotEmpty) {
                          insertNewBins(nameBinController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyHome(
                                        ID: widget.ID,
                                      )));
                        }
                      },
                      child: Container(
                        width: 100,
                        child: Center(
                          child: Text(
                            'ADD',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: kAppColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  void insertNewBins(String name) async {
    firestoreRef.collection("bins").doc(name).set({
      "waste_producer_id": widget.ID,
      "id": name,
      "weight": 0,
      "token": 0,
      "status": 1,
    }).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("New bin added !")));
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
