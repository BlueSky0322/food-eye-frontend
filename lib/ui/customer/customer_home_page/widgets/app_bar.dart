import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    backgroundColor: appbar,
    // centerTitle: true,
    elevation: 6,
    toolbarHeight: 70,
    title: Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/just-eye-logo.png',
            width: 70,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          "FoodEye",
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: appbarText,
          ),
        ),
      ],
    ),
    actions: [
      Builder(
        builder: (context) => IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryBG,
                width: 1,
              ),
            ),
            child: CircleAvatar(
              radius: 25.0,
              backgroundColor: primaryBG,
              backgroundImage: Image.asset('assets/images/avatar.png').image,
            ),
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
    ],
  );
}
