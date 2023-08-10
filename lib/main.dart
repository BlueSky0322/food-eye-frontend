import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/ui/customer/customer_bottom_nav_bar/nav_bar_state.dart';
import 'package:food_eye_fyp/ui/customer/customer_bottom_nav_bar/nav_bar_wrapper.dart';
import 'package:food_eye_fyp/ui/seller/seller_bottom_nav_bar/nav_bar_state.dart';
import 'package:food_eye_fyp/ui/seller/seller_bottom_nav_bar/nav_bar_wrapper.dart';
import 'package:food_eye_fyp/ui/landing_pages/launch_page/launch_page.dart';
import 'package:food_eye_fyp/ui/landing_pages/splash_page/splash_page.dart';
import 'package:food_eye_fyp/utils/http_overrides.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
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
              create: (context) => (NavBarState(0)),
              child: const NavBarWrapper(),
            ),
        '/products': (context) => ChangeNotifierProvider(
              create: (context) => (NavBarState(1)),
              child: const NavBarWrapper(),
            ),
        '/orders': (context) => ChangeNotifierProvider(
              create: (context) => (NavBarState(2)),
              child: const NavBarWrapper(),
            ),
        '/custhome': (context) => ChangeNotifierProvider(
              create: (context) => (CustNavBarState(1)),
              child: const CustNavBarWrapper(),
            ),
        '/custorders': (context) => ChangeNotifierProvider(
              create: (context) => (CustNavBarState(2)),
              child: const CustNavBarWrapper(),
            ),
        '/splash': (context) => const SplashPage(),
      },
      home: const LaunchPage(),
    );
  }
}
