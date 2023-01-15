import 'package:altrad_qr/constants.dart';
import 'package:flutter/material.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key, required this.ID}) : super(key: key);
  final String ID;
  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppColor,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              child: Text('The Qr Code should be here'),
            ),
          ),
        ));
  }
}
