import 'package:flutter/material.dart';

import '../../../constants.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton(
      {required this.textButton, Key? key, required this.onPressed})
      : super(key: key);
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: kAppColor,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            textButton,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
