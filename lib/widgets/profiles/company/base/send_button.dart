//This page contains the fields where it is possible to type the serial number and a button to send the request

import 'package:flutter/material.dart';

import '../../../../constants.dart';


class SendButton extends StatefulWidget {
  const SendButton({Key? key, required this.ID}) : super(key: key);
  final String ID;
  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  final TextEditingController nameBinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widget_height = 0.85;

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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kAppColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kAppColor, width: 2.0),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(top: height * widget_height),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: barCodeField,
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                width: 100,
                height: 50,
                child: Center(
                  child: Text(
                    'SEND',
                    style: const TextStyle(
                      color: Colors.white,
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
    );
  }
}
