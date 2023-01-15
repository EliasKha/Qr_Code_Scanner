import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/side_menu.dart';
import 'base/custom_send_qr_scanner.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({Key? key, required this.ID}) : super(key: key);
  final String ID;

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon_0: IconButton(
          icon: kRefresh,
          onPressed: () {
            setState(() {});
          },
        ),
      ),
      drawer: const NavigationDrawer(),
      body: SafeArea(child: const Center(child: CustomSendQrScanner())),
    );
  }
}
