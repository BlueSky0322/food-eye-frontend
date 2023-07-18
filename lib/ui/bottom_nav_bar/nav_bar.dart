import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

import 'nav_bar_state.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<NavBarState>(context);
    return CurvedNavigationBar(
      backgroundColor: pageBG,
      buttonBackgroundColor: const Color.fromARGB(255, 49, 61, 114),
      height: 55,
      color: appbar,
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(
          Icons.home,
          size: 30,
          color: appbarText,
        ),
        Icon(
          Icons.my_library_add_outlined,
          size: 30,
          color: appbarText,
        ),
        Icon(
          Icons.trending_up_rounded,
          size: 30,
          color: appbarText,
        ),
      ],
      onTap: (index) {
        state.selectedIndex = index;
      },
      index: state.selectedIndex,
    );
    // return BottomNavigationBar(
    //   backgroundColor: appbar,
    //   elevation: 3,
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.apps_rounded),
    //       label: 'Items',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.my_library_add_outlined),
    //       label: 'Add item',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.trending_up_rounded),
    //       label: 'Overview',
    //     ),
    //   ],
    //   type: BottomNavigationBarType.fixed,
    //   currentIndex: state.selectedIndex,
    //   selectedItemColor: Colors.teal,
    //   unselectedItemColor: primaryBG,
    //   iconSize: 25,
    //   onTap: (index) => state.selectedIndex = index,
    // );
  }
}
