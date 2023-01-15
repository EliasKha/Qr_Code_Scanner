//This is the page which sends *** when the qr_code is scanned

import 'package:flutter/material.dart';

import '../base/custom_send_qr_scanner.dart';
import '../base/send_button.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key, required this.ID}) : super(key: key);
  final String ID;

  @override
  State<StatefulWidget> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
              child: CustomSendQrScanner(),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.8),
              child: Container(
                color: Colors.white,
                height: height * 0.2,
              ),
            ),
            SendButton(ID: widget.ID),
          ],
        ),
      ),
    );
  }
}
