import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

// import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_eye_fyp/service/item_service.dart';
import 'package:food_eye_fyp/service/notification_service.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/http_utils.dart';

class BackgroundService {
  static bool isRegistered = false;
  // static int daysBeforeToNotify = await loadDaysBeforeToNotifyFromPrefs();
  // static int _daysBeforeToNotify = 7; // Private variable for storing the value
  //static int daysBeforeToNotify = 20;
  // static int get daysBeforeToNotify => _daysBeforeToNotify; // Getter

  // static set daysBeforeToNotify(int value) {
  //   _daysBeforeToNotify = value; // Update the value
  //   // if (isRegistered) {
  //   //   restartDateCheckerBackgroundService2(); // Restart the background service
  //   // }
  // }

  //static ValueNotifier<int> daysBeforeToNotify = ValueNotifier<int>(7);
  final itemService = ItemService();
  // static int get daysBeforeToNotify => _daysBeforeToNotify;
  // static set daysBeforeToNotify(int value) {
  //   _daysBeforeToNotify = value;
  // }
  // BackgroundService({required int days}) : daysBeforeToNotify = days;

  @pragma('vm:entry-point')
  static Future<void> _onStart(ServiceInstance service) async {
    //String? recentNotification;
    HttpOverrides.global = MyHttpOverrides();
    final notificationService = NotificationService();
    final itemService = ItemService();

    DartPluginRegistrant.ensureInitialized();

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    Timer.periodic(const Duration(hours: 5), (Timer t) async {
      final prefs = await SharedPreferences.getInstance();
      final daysBeforeToNotify = prefs.getInt('daysBeforeToNotify') ?? 7;
      // print("[DEBUG]" + daysBeforeToNotify.toString());
      final items =
          await itemService.getItemsExpiringWithin(daysBeforeToNotify);
      if (items.isNotEmpty) {
        // Perform your action here, such as displaying a notification
        if (items.length == 1) {
          for (final item in items) {
            notificationService.showNotification(
              'Item Expiring!',
              'Item "${item.itemName}" is expiring soon!',
            );
          }
        } else {
          notificationService.showNotification(
            'Items Expiring!',
            'You have ${items.length} items expiring soon!',
          );
        }
      }
    });
  }

  static void unregisterDateCheckerBackgroundService() async {
    isRegistered = false;
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    }
  }

  static void registerDateCheckerBackgroundService() async {
    //unregisterDateCheckerBackgroundService();
    isRegistered = true;
    final service = FlutterBackgroundService();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      dateCheckerChannelId,
      dateCheckerChannelName,
      description: 'Checking items',
      // description
      importance: Importance.low, // importance must be at low or higher level
    );

    final notificationsPlugin = NotificationService().notificationPlugin;
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
          onStart: _onStart,
          autoStart: true,
          isForegroundMode: true,
          notificationChannelId: dateCheckerChannelId,
          initialNotificationTitle: 'FoodEye',
          initialNotificationContent: 'Watching out for expired items',
          foregroundServiceNotificationId: dateCheckerNotificationId,
          autoStartOnBoot: true),
      iosConfiguration: IosConfiguration(
        onForeground: _onStart,
      ),
    );
  }

  // static Future<void> restartDateCheckerBackgroundService(int days) async {
  //   unregisterDateCheckerBackgroundService();
  //   daysBeforeToNotify = days;
  //   await Future.delayed(Duration(seconds: 2));
  //   registerDateCheckerBackgroundService();
  // }

  static Future<void> restartDateCheckerBackgroundService() async {
    unregisterDateCheckerBackgroundService();
    await Future.delayed(Duration(seconds: 2));
    registerDateCheckerBackgroundService();
  }

  // static Future<void> updateDaysBeforeToNotify(int days) async {
  //   unregisterDateCheckerBackgroundService();
  //   daysBeforeToNotify = days;
  //   registerDateCheckerBackgroundService();
  // }

  // static Future<int> loadDaysBeforeToNotifyFromPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt('daysBeforeToNotify') ?? 7;
  // }
  static Future<void> loadDaysBeforeToNotifyFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getInt('daysBeforeToNotify') ?? 7;
  }

  static Future<void> saveDaysBeforeToNotifyToPrefs(int days) async {
    final prefs = await SharedPreferences.getInstance();
    log("[DEBUG] shared preferences stored " + days.toString());
    await prefs.setInt('daysBeforeToNotify', days);
  }
}
