import 'dart:developer';

import 'package:flutter/material.dart';

import '../../data/model/item_response.dart';
import '../../service/item_service.dart';

class AnalyticsPageState extends ChangeNotifier {
  final BuildContext context;
  final _itemService = ItemService();
  final ValueNotifier<bool> swapView = ValueNotifier<bool>(false);
  List<ItemResponseObject> feItemList = [];
  List<ItemResponseObject> feItemList2 = [];

  AnalyticsPageState(this.context) {
    loadItems();
  }

  void toggleView() {
    swapView.value = !swapView.value;
    notifyListeners();
  }

  Future<void> loadItems() async {
    try {
      List<ItemResponseObject> items = await _itemService.getAllItems();
      feItemList = items;
      notifyListeners();
    } catch (error) {
      log('Error loading items: $error');
    }
  }

  Future<List<ItemResponseObject>> reloadItems() async {
    try {
      List<ItemResponseObject> items = await _itemService.getAllItems();
      // notifyListeners();
      return items;
    } catch (error) {
      log('Error loading items: $error');
      rethrow; // Rethrow the error to be handled by the caller
    }
  }

  Future<void> deleteItem(int itemID) async {
    await _itemService.deleteItem(itemID);
    await loadItems();
  }
}
