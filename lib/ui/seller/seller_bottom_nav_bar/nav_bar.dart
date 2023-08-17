import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_eye_fyp/ui/seller/seller_bottom_nav_bar/nav_bar_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  void navigateToSpecificIndex(BuildContext context, int index) {
    final state = Provider.of<NavBarState>(context, listen: false);
    state.selectedIndex = index;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

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
          Icons.shopping_basket_rounded,
          size: 30,
          color: appbarText,
        ),
        Icon(
          Icons.list_alt_rounded,
          size: 30,
          color: appbarText,
        ),
      ],
      onTap: (index) {
        state.selectedIndex = index;
      },
      index: state.selectedIndex,
    );
  }
}
