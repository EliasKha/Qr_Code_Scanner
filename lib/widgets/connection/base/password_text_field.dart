import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  PasswordTextField({Key? key, required this.passwordController})
      : super(key: key);

  late String onSave;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("The password cannot be empty !");
        } else if (value.length < 6) {
          return ('the password is too short !');
        } else if (!value.contains(RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])'))) {
          return ('The password has to contain at least a capital letter,\n a lowercase letter, a number and a special character !');
        } else if (!regex.hasMatch(value)) {
          return ("Please enter a valid password (minimum 6 characters)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
