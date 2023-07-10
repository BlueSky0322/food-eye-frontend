import 'package:flutter/widgets.dart';
import 'package:food_eye_fyp/ui/add_item_page/add_item.dart';
import 'package:food_eye_fyp/ui/add_item_page/add_item_state.dart';
import 'package:food_eye_fyp/ui/analytics_page/category_page.dart';
import 'package:food_eye_fyp/ui/analytics_page/category_page_state.dart';
import 'package:provider/provider.dart';

import '../home_page/home_page.dart';
import '../home_page/home_page_state.dart';

class NavBarState extends ChangeNotifier {
  int _selectedIndex = 0;

  final List<Widget> widgetOptions = <Widget>[
    ChangeNotifierProvider(
      create: (context) => HomePageState(context),
      child: const HomePage(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddItemState(context),
      child: const AddItemPage(),
    ),
    ChangeNotifierProvider(
      create: (context) => AnalyticsPageState(context),
      child: const AnalyticsPage(),
    ),
  ];

  final List<String> widgetTitles = ['Items', 'Add item', 'Overview'];

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  void navigateToAddItemPage() {
    // Set the selected index to the home page index (0)
    selectedIndex = 1;
  }
}
