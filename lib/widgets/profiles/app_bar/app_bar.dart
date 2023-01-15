import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {required this.icon_0,
      this.icon_1 = const SizedBox(width: 0, height: 0),
      Key? key})
      : super(key: key);
  final Widget icon_1;
  final Widget icon_0;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: kAppColor,
        elevation: 5,
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: icon_0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: icon_1,
              ),
            ],
          )
        ]);
  }
}
