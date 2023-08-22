import 'package:flutter/material.dart';
import 'package:food_eye_fyp/service/background_service.dart';

import '../../../../utils/constants.dart';

class ConfirmLogoutDialog extends StatelessWidget {
  const ConfirmLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm Logout',
        style: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.red.shade700,
        ),
      ),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          fontFamily: 'Outfit',
          color: primaryBG,
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  width: 2,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ),
          child: Text(
            'Logout',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.red.shade700,
            ),
          ),
          onPressed: () {
            BackgroundService.unregisterDateCheckerBackgroundService();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/splash',
              (route) => false,
            );
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: appbarText,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: primaryBG,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
