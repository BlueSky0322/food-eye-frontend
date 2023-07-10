import 'package:flutter/material.dart';
import 'package:food_eye_fyp/service/background_service.dart';
import 'package:food_eye_fyp/ui/home_page/components/nav_drawer/confirm_logout.dart';
// import 'package:food_eye_fyp/ui/settings_page/set.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

Widget buildSettings(BuildContext context) {
  // final bgServicestate = Provider.of<BackgroundService>(context);
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
                // int newDaysBeforeToNotify =
                //     BackgroundService.daysBeforeToNotify;
                int newDaysBeforeToNotify = 0;
                return AlertDialog(
                  title: const Text("Notification Settings"),
                  content: TextField(
                    onChanged: (value) {
                      newDaysBeforeToNotify = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Days before expiration",
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // BackgroundService.daysBeforeToNotify =
                        //     newDaysBeforeToNotify;
                        // print(newDaysBeforeToNotify.toString() +
                        //     "/" +
                        //     BackgroundService.daysBeforeToNotify.toString());
                        await BackgroundService.saveDaysBeforeToNotifyToPrefs(
                            newDaysBeforeToNotify);
                        await BackgroundService
                            .restartDateCheckerBackgroundService();
                        // await BackgroundService.updateDaysBeforeToNotify(
                        //     newDaysBeforeToNotify);
                        // BackgroundService
                        //     .unregisterDateCheckerBackgroundService();
                        // BackgroundService
                        //     .registerDateCheckerBackgroundService();
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
                    ),
                  ],
                );
              },
            );
          },
        ),

        // ListTile(
        //   iconColor: primaryBG,
        //   leading: const Icon(Icons.notifications),
        //   title: const Text(
        //     "Notification Settings",
        //     style: TextStyle(
        //       fontFamily: 'Outfit',
        //       color: primaryBG,
        //     ),
        //   ),
        //   onTap: () {

        //   },
        // ),
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
              builder: (BuildContext context) => const ConfirmLogoutDialog(),
            );
          },
        ),
      ],
    ),
  );
}
