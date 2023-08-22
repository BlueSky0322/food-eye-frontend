import 'package:flutter/widgets.dart';
import 'package:food_eye_fyp/ui/customer/about_page/about_page.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/customer_home_page.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/customer_home_page_state.dart';
import 'package:food_eye_fyp/ui/customer/customer_order_page/customer_order_page.dart';
import 'package:food_eye_fyp/ui/customer/customer_order_page/customer_order_page_state.dart';
import 'package:provider/provider.dart';

class CustNavBarState extends ChangeNotifier {
  int _selectedIndex = 0;
  CustNavBarState(this._selectedIndex);
  final List<Widget> widgetOptions = <Widget>[
    // ChangeNotifierProvider(
    //   create: (context) => AddItemState(context),
    //   child: const AddItemPage(),
    // ),
    const AboutPage(),
    ChangeNotifierProvider(
      create: (context) => CustomerHomePageState(context),
      child: const CustomerHomePage(),
    ),

    ChangeNotifierProvider(
      create: (context) => CustOrderPageState(context),
      child: const CustOrderPage(),
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

  void navigateToProductsPage() {
    // Set the selected index to the home page index (0)
    selectedIndex = 1;
  }
}
