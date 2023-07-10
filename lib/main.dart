import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_eye_fyp/service/notification_service.dart';
import 'package:food_eye_fyp/ui/common/nav_bar_state.dart';
import 'package:food_eye_fyp/ui/common/nav_bar_wrapper.dart';
import 'package:food_eye_fyp/ui/splash_page/splash_page.dart';
import 'package:food_eye_fyp/utils/http_utils.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  // tz.initializeTimeZones();
  HttpOverrides.global = MyHttpOverrides();
  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home': (context) => ChangeNotifierProvider(
              create: (context) => (NavBarState()),
              child: const NavBarWrapper(),
            ),
        '/splash': (context) => const SplashPage(),
        // '/splash': (context) => ChangeNotifierProvider(
        //       create: (context) => SplashPageState(context),
        //       child: const SplashPage(),
        //     ),
      },
      home: const SplashPage(),
      // home: ChangeNotifierProvider(
      //     // create: (context) => HomePageState(context), child: const HomePage()),
      //     create: (context) => SplashPageState(context),
      //     child: const SplashPage()),
    );
  }
}
