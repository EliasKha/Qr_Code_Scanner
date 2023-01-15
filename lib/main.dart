import 'package:altrad_qr/widgets/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCHmFeY7yyWsGklc3F3rNp6W-JrfDGhNmM",
    appId: "1:636407982124:android:b542b57ee8678926b14989",
    messagingSenderId: "636407982124",
    projectId: "altradqr",
  ));
  runApp(const MyApp());
}
