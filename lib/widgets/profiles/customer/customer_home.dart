import 'package:altrad_qr/widgets/profiles/customer/pages/qr_code_page.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../app_bar/app_bar.dart';
import '../app_bar/side_menu.dart';
import '../customer/base/custom_request_container.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key, required this.ID}) : super(key: key);
  final String ID;

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
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
        icon_1: IconButton(
            icon: kQrCodeIcon,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QrCodePage(ID: widget.ID)));
            }),
      ),
      drawer: const NavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListRequests(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
