import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

import 'header.dart';
import 'menu_items.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: pageBG,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildSettings(context),
          ],
        ),
      ),
    );
  }
}
