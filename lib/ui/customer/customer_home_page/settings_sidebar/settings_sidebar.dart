import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

import 'header.dart';
import 'sidebar_items.dart';

class SettingsSidebar extends StatelessWidget {
  const SettingsSidebar({super.key});

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
