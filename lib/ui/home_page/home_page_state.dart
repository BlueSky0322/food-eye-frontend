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
  List<Item> _itemList = [];
  HomePageState(this.context);

  UnmodifiableListView<Item> get itemList => UnmodifiableListView(_itemList);
  addItem(Item item) {
    _itemList.add(item);
    notifyListeners();
  }
}
