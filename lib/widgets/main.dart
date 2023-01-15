import 'package:flutter/material.dart';

import 'connection/log_in/connection.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AltraqQr by Elias Khadraoui',
      theme: ThemeData(),
      home: Connection(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
    );
  }
}
