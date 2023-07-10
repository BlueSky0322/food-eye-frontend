import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_eye_fyp/utils/constants.dart';

class NotificationService {
  BuildContext? _context;
  NotificationService._internal();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get notificationPlugin => _notificationPlugin;

  Future<void> initNotification(context) async {
    _context ??= context;
    const androidInitialization =
        AndroidInitializationSettings('just_eye_logo');
    const iOSInitialization = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iOSInitialization,
    );

    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        log("Redirecting...");
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      },
    );

    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
      feItemChannelId,
      feItemChannelName,
      priority: Priority.max,
      importance: Importance.max,
    ));
  }

  Future showNotification(String title, String body) async {
    return notificationPlugin.show(
      feItemNotificationId,
      title,
      body,
      await notificationDetails(),
    );
  }
}
