import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_decoration/input_decoration_additem.dart';

import '../../../../service/background_service.dart';
import '../../../../service/shared_preferences_service.dart';
import '../../../../utils/constants.dart';

class NotificationSettings extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

  NotificationSettings({super.key});

  bool _isValidDayValue(String value) {
    const pattern = r'^[1-9][0-9]*$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<void> _saveNotificationSettings(
      BuildContext context, int newDaysBeforeToNotify) async {
    await SharedPrefsService.saveDaysBeforeToNotifyToPrefs(
        newDaysBeforeToNotify);
    await BackgroundService.restartDateCheckerBackgroundService();

    Future.microtask(
      () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // int newDaysBeforeToNotify = await SharedPrefsService.loadDaysBeforeToNotifyFromPrefs();
    return FutureBuilder<int>(
        future: SharedPrefsService.loadDaysBeforeToNotifyFromPrefs(),
        builder: (context, snapshot) {
          int newDaysBeforeToNotify = snapshot.data ?? 0;
          return AlertDialog(
            title: const Text(
              "Notification Settings",
              style: TextStyle(
                fontFamily: 'Outfit',
                color: primaryBG,
              ),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Current Settings: ",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.teal.shade800,
                        ),
                      ),
                      Text(
                        "$newDaysBeforeToNotify day(s)",
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: primaryBG,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _textFieldController,
                    keyboardType: TextInputType.number,
                    decoration: AddItemInputDecoration.addItemInputDecoration(
                      labelText: "Notify me before",
                      hintText: "Days before expiration",
                      prefixIcon: Icons.notifications_active_rounded,
                      suffixIcon: null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be blank';
                      }
                      if (!_isValidDayValue(value)) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        width: 2,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newDaysBeforeToNotify =
                        int.parse(_textFieldController.text.trim());
                    _saveNotificationSettings(context, newDaysBeforeToNotify);
                  }
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
        });
  }
}
