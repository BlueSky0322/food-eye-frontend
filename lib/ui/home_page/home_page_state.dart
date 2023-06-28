import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/model/item.dart';

class HomePageState extends ChangeNotifier {
  final BuildContext context;
  DateTime nearestExpDate = DateTime.now();
  int expItemCount = 0;
  String itemName = "AAa";
  int quantity = 0;
  DateTime datePurchased = DateTime(2022, 12, 10);
  DateTime dateExpiresOn = DateTime(2022, 12, 15);
  final List<Item> _itemList = [
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
  ];

  HomePageState(this.context);

  UnmodifiableListView<Item> get itemList => UnmodifiableListView(_itemList);
  addItem(Item item) {
    _itemList.add(item);
    notifyListeners();
  }
}
