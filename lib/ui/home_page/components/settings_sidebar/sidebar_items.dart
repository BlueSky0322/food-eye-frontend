import 'package:flutter/material.dart';
import 'package:food_eye_fyp/ui/home_page/components/settings_sidebar/confirm_logout.dart';
import 'package:food_eye_fyp/ui/home_page/components/settings_sidebar/notification_settings.dart';
import 'package:food_eye_fyp/utils/constants.dart';

Widget buildSettings(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(18),
    child: Wrap(
      runSpacing: 12,
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryBG,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            iconColor: appbarText,
            leading: const Icon(Icons.settings),
            title: const Text(
              "Settings Tab",
              style: TextStyle(
                fontFamily: 'Outfit',
                color: appbarText,
              ),
            ),
            onTap: () {},
          ),
        ),
        const Divider(
          color: Colors.black54,
        ),
        ListTile(
          iconColor: primaryBG,
          leading: const Icon(Icons.notifications),
          title: const Text(
            "Notification Settings",
            style: TextStyle(
              fontFamily: 'Outfit',
              color: primaryBG,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const NotificationSettings();
                });
          },
        ),
        ListTile(
          iconColor: primaryBG,
          leading: const Icon(Icons.logout),
          title: const Text(
            "Logout",
            style: TextStyle(
              fontFamily: 'Outfit',
              color: primaryBG,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const ConfirmLogoutDialog(),
            );
          },
        ),
      ],
    ),
  );
}
