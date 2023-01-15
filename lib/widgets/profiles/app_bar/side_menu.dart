import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../connection/log_in/connection.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        color: kAppColor,
        height: 100,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('surname' + ' ' + 'firstname',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ))
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {},
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Generale information'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Security and confidentiality'),
              onTap: () {},
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Connection()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
