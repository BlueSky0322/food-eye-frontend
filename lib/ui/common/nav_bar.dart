import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

import 'nav_bar_state.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<NavBarState>(context);
    return BottomNavigationBar(
      backgroundColor: primaryBG,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.apps_rounded),
          label: 'Items',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner_sharp),
          label: 'Add item',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up_rounded),
          label: 'Overview',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: state.selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white30,
      iconSize: 40,
      onTap: (index) => state.selectedIndex = index,
    );
  }
}
