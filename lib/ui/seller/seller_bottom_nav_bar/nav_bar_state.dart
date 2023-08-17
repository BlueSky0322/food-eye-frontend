import 'package:flutter/widgets.dart';
import 'package:food_eye_fyp/ui/seller/add_item_page/add_item.dart';
import 'package:food_eye_fyp/ui/seller/add_item_page/add_item_state.dart';
import 'package:food_eye_fyp/ui/seller/orders_page/orders_page.dart';
import 'package:food_eye_fyp/ui/seller/orders_page/orders_page_state.dart';
import 'package:food_eye_fyp/ui/seller/products_page/products_page.dart';
import 'package:food_eye_fyp/ui/seller/products_page/products_page_state.dart';
import 'package:provider/provider.dart';

import '../seller_home_page/seller_home_page.dart';
import '../seller_home_page/seller_home_page_state.dart';

class NavBarState extends ChangeNotifier {
  int _selectedIndex = 0;
  NavBarState(this._selectedIndex);
  final List<Widget> widgetOptions = <Widget>[
    ChangeNotifierProvider(
      create: (context) => SellerHomePageState(context),
      child: const SellerHomePage(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductsPageState(context),
      child: const ProductsPage(),
    ),
    ChangeNotifierProvider(
      create: (context) => OrdersPageState(context),
      child: const OrdersPage(),
    ),
  ];

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
