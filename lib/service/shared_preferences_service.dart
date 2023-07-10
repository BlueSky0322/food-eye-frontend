import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static Future<void> saveDaysBeforeToNotifyToPrefs(int days) async {
    final prefs = await SharedPreferences.getInstance();
    log("[DEBUG] shared preferences stored: $days");
    await prefs.setInt('daysBeforeToNotify', days);
  }

  static Future<int> loadDaysBeforeToNotifyFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('daysBeforeToNotify') ?? 7;
  }
}
