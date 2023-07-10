import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
// import 'package:workmanager/workmanager.dart';
import '../../service/background_service.dart';
import '../../service/notification_service.dart';
import 'nav_bar.dart';
import 'nav_bar_state.dart';

class NavBarWrapper extends StatelessWidget {
  const NavBarWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService().initNotification(context);
    BackgroundService.registerDateCheckerBackgroundService();
    final state = context.watch<NavBarState>();
    return Scaffold(
      body: Center(
        child: state.widgetOptions.elementAt(state.selectedIndex),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
