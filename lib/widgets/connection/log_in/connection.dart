import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../profiles/company/home.dart';
import '../../profiles/customer/customer_home.dart';
import '../base/loading_button.dart';
import '../base/email_text_field.dart';
import '../base/password_text_field.dart';
import '../sign_in/registration.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();

  final firestoreRef = FirebaseFirestore.instance;

  final String CompanyRoleValue = 'company';
  final String CustomerRoleValue = 'customer';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final snackbar = SnackBar(
      content: const Text(
    "This user doesn't exist !",
    textAlign: TextAlign.center,
  ));

  void checkUser(String email, String password) async {
    final userRef = firestoreRef.collection("users");

    final snackbar = SnackBar(
        content: const Text(
      "This user doesn't exist !",
      textAlign: TextAlign.center,
    ));

    final user = await userRef
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();

    if (user.docs.isNotEmpty) {
      final role = user.docs.first.get('role');
      final id = user.docs.first.get('id');

      if (emailController.text.toString() == email &&
          passwordController.text.toString() == password &&
          CompanyRoleValue == role) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompanyHome(
                      ID: id,
                    )));
      }
      if (emailController.text.toString() == email &&
          passwordController.text.toString() == password &&
          CustomerRoleValue == role) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomerHome(
                    ID: id,
                  )),
        );
      }
    } else {
      print(emailController.text.toString());
      print(passwordController.text.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SignInButton = GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Registration()));
      },
      child: Text(
        'Sign In',
        style: TextStyle(
            color: kAppColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                height: 450,
                width: 350,
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 25,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Connection',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      EmailTextField(
                        emailController: emailController,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      PasswordTextField(passwordController: passwordController),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Don't have an account ? "),
                          SignInButton,
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      LoadingButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            checkUser(emailController.text.toString(),
                                passwordController.text.toString());
                          }
                        },
                        textButton: 'Log in',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
