import 'package:flutter/material.dart';
import 'package:food_eye_fyp/ui/common/nav_bar_state.dart';
import 'package:food_eye_fyp/ui/common/nav_bar_wrapper.dart';
import 'package:food_eye_fyp/ui/splash_page/splash_page.dart';
import 'package:food_eye_fyp/ui/splash_page/splash_page_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
        '/splash': (context) => ChangeNotifierProvider(
              create: (context) => SplashPageState(context),
              child: const SplashPage(),
            ),
      },
      home: ChangeNotifierProvider(
          // create: (context) => HomePageState(context), child: const HomePage()),
          create: (context) => SplashPageState(context),
          child: const SplashPage()),
    );
  }
}
