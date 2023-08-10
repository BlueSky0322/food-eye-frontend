import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/background_service.dart';
import '../../../service/notification_service.dart';
import 'nav_bar.dart';
import 'nav_bar_state.dart';

class CustNavBarWrapper extends StatelessWidget {
  const CustNavBarWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustNavBarState>();
    return Scaffold(
      body: Center(
        child: state.widgetOptions.elementAt(state.selectedIndex),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
