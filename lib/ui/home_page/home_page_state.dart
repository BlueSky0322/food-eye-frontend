import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/model/item.dart';
import 'package:food_eye_fyp/ui/home_page/components/show_menu_ui.dart';
import 'package:http/http.dart';

import '../../utils/constants.dart';

class HomePageState extends ChangeNotifier {
  final BuildContext context;
  final ValueNotifier<bool> isDescending = ValueNotifier<bool>(false);
  // Define the sorting options
  final sortingOptions = [
    'Name',
    'Quantity',
    'Date',
  ];

  String sortByOption = "Name";
  DateTime nearestExpDate = DateTime.now();
  int expItemCount = 0;
  String itemName = "AAa";
  int quantity = 0;
  DateTime datePurchased = DateTime(2022, 12, 10);
  DateTime dateExpiresOn = DateTime(2022, 12, 15);

  final List<Item> itemList = [
    Item(
      itemName:
          'Goodfellow and Co No. 01 Blue Sage Tonka Texturizing Fiber, 4 Oz.',
      itemType: 'Fruit',
      quantity: 5,
      datePurchased: DateTime.now(),
      dateExpiresOn: DateTime.now().subtract(Duration(days: 2)),
      imagePath: 'assets/images/fruit.png',
      storedAt: "Pantry",
      description: 'Fresh and juicy apple',
    ),
    Item(
      itemName: 'Banana',
      itemType: 'Fruit',
      quantity: 3,
      datePurchased: DateTime.now(),
      dateExpiresOn: DateTime.now().add(Duration(days: 7)),
      imagePath: 'assets/images/fruit.png',
      storedAt: "Pantry",
      description: 'Sweet and nutritious banana',
    ),
    Item(
      itemName: 'Orange',
      itemType: 'Fruit',
      quantity: 2,
      datePurchased: DateTime.now(),
      dateExpiresOn: DateTime.now().add(Duration(days: 10)),
      imagePath: 'assets/images/fruit.png',
      storedAt: "Pantry",
      description: 'Tangy and refreshing orange',
    ),
    Item(
      itemName: 'Orange',
      itemType: 'Fruit',
      quantity: 2,
      datePurchased: DateTime.now(),
      dateExpiresOn: DateTime.now().add(Duration(days: 10)),
      imagePath: 'assets/images/fruit.png',
      storedAt: "Pantry",
      description: 'Tangy and refreshing orange',
    ),
    Item(
      itemName: 'Orange',
      itemType: 'Fruit',
      quantity: 2,
      datePurchased: DateTime.now(),
      dateExpiresOn: DateTime.now().add(Duration(days: 10)),
      imagePath: 'assets/images/fruit.png',
      storedAt: "Pantry",
      description: 'Tangy and refreshing orange',
    ),
    Item(
      itemName: 'Orange',
      itemType: 'Fruit',
      quantity: 2,
      datePurchased: DateTime.now(),
      dateExpiresOn: DateTime.now().add(Duration(days: 10)),
      imagePath: 'assets/images/fruit.png',
      storedAt: "Pantry",
      description: 'Tangy and refreshing orange',
    ),
  ];

  HomePageState(this.context);
  void toggleSortingOrder() {
    isDescending.value = !isDescending.value;
    notifyListeners();
  }

  List<Item> sortItems(List<Item> items, bool isDescending, String sortBy) {
    switch (sortBy) {
      case 'Name':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.itemName!.compareTo(item1.itemName!)
              : item1.itemName!.compareTo(item2.itemName!));
      case 'Quantity':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.quantity.compareTo(item1.quantity)
              : item1.quantity.compareTo(item2.quantity));
      case 'Date':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.dateExpiresOn!.compareTo(item1.dateExpiresOn!)
              : item1.dateExpiresOn!.compareTo(item2.dateExpiresOn!));
      default:
        break;
    }

    return items;
  }

  void showSortingOptions(BuildContext context) {
    // Show the popup menu
    showMenuUI(context, sortingOptions).then((selectedOption) {
      handleSortingOptionSelected(selectedOption);
    });
  }

  void handleSortingOptionSelected(String? selectedOption) {
    if (selectedOption != null) {
      sortByOption = selectedOption;
      sortItems(
        itemList,
        isDescending.value,
        selectedOption,
      );
      notifyListeners();
    }
  }
}
