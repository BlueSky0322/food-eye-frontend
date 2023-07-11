import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_eye_fyp/service/item_service.dart';
import 'package:food_eye_fyp/service/notification_service.dart';
import 'package:food_eye_fyp/service/shared_preferences_service.dart';
import 'package:food_eye_fyp/utils/constants.dart';

import '../utils/http_utils.dart';

class BackgroundService {
  static bool isRegistered = false;
  final itemService = ItemService();

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

    Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      final daysBeforeToNotify =
          await SharedPrefsService.loadDaysBeforeToNotifyFromPrefs();
      final items =
          await itemService.getItemsExpiringWithin(daysBeforeToNotify);
      if (items.isNotEmpty) {
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
    isRegistered = true;
    final service = FlutterBackgroundService();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      dateCheckerChannelId,
      dateCheckerChannelName,
      description: 'Checking items',
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

  static Future<void> restartDateCheckerBackgroundService() async {
    unregisterDateCheckerBackgroundService();
    await Future.delayed(const Duration(seconds: 2));
    registerDateCheckerBackgroundService();
  }
}
