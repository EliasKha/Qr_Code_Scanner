import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants.dart';
import '../base/email_text_field.dart';
import '../base/first_name_field.dart';
import '../base/loading_button.dart';
import '../base/password_text_field.dart';
import '../base/surname_field.dart';
import '../log_in/connection.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String CustomerRoleValue = 'Customer';
  final String CompanyRoleValue = 'Company';

  final firestoreRef = FirebaseFirestore.instance;

  String? selectedValue;
  final _dropdownFormKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Customer"), value: CustomerRoleValue),
      DropdownMenuItem(child: Text("Company"), value: CompanyRoleValue),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final dropdownProfiles = Form(
      key: _dropdownFormKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 10),
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems),
          ),
        ],
      ),
    );

    final LogInButton = GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Connection()));
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: 580,
                  width: 500,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 25,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          height: 48.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FirstNameField(
                                  nameController: firstnameController),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Expanded(
                              child: SurnameField(
                                nameController: surnameController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        EmailTextField(emailController: emailController),
                        const SizedBox(
                          height: 8.0,
                        ),
                        PasswordTextField(
                            passwordController: passwordController),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "choose a role :",
                          style: TextStyle(fontSize: 18),
                        ),
                        dropdownProfiles,
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Don't have an account ? "),
                            LogInButton,
                          ],
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        LoadingButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (firstnameController.text.isNotEmpty &&
                                  surnameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  selectedValue != null) {
                                insertNewUser(
                                    firstnameController.text,
                                    surnameController.text,
                                    emailController.text,
                                    passwordController.text);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Connection()),
                                );
                              }
                            }
                          },
                          textButton: 'Register',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void insertNewUser(
      String firstname, String surname, String email, String password) async {
    var uniqueKey = firestoreRef.collection("users").doc();
    firestoreRef.collection("users").doc(uniqueKey.id).set({
      "id": uniqueKey.id,
      "firstname": firstname,
      "surname": surname,
      "email": email,
      "password": password,
      "role": selectedValue.toString().toLowerCase(),
      "assigned_company": "KFC"
    }).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("new User Inserted !")));
    });
    firstnameController.clear();
    surnameController.clear();
    emailController.clear();
    passwordController.clear();
  }
  void getRandomCompanyId(
      String firstname, String surname, String email, String password) async {
    var uniqueKey = firestoreRef.collection("company").doc();
    var randomValue = Math.random();
    ref.update({ ..., 'r': randomValue });

    ...

    var ref = firebase.database().ref('companies/01/users')
    ref.orderByChild('r').limitToFirst(1).once('value').then(function(snapshot) {
    var data = snapshot.val()
    ...
    snapshot.remove()
    });
  };
}
