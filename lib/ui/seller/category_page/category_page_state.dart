import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/request_response_model/item_response.dart';
import '../../../service/item_service.dart';

class AnalyticsPageState extends ChangeNotifier {
  final BuildContext context;
  final _itemService = ItemService();
  final ValueNotifier<bool> swapView = ValueNotifier<bool>(false);
  List<ItemResponse> feItemList = [];
  List<ItemResponse> feItemList2 = [];

  late UserProvider userProvider;
  AnalyticsPageState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadItems();
  }

  void toggleView() {
    swapView.value = !swapView.value;
    notifyListeners();
  }

  Future<void> loadItems() async {
    try {
      List<ItemResponse> items =
          await _itemService.getAllItems(userProvider.userId);
      feItemList = items;
      notifyListeners();
    } catch (error) {
      log('Error loading items: $error');
    }
  }

  Future<List<ItemResponse>> reloadItems() async {
    try {
      List<ItemResponse> items =
          await _itemService.getAllItems(userProvider.userId);
      // notifyListeners();
      return items;
    } catch (error) {
      log('Error loading items: $error');
      rethrow;
    }
  }

  Future<void> deleteItem(int itemID) async {
    await _itemService.deleteItem(itemID);
    await loadItems();
  }
}
