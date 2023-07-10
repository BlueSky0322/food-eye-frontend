import 'package:flutter/material.dart';
import 'package:food_eye_fyp/service/item_service.dart';
import 'package:food_eye_fyp/ui/home_page/components/sorting_options.dart';
import 'package:http/http.dart';

import '../../data/model/item_response.dart';

class HomePageState extends ChangeNotifier {
  final BuildContext context;
  final client = Client();
  final _itemService = ItemService();
  final ValueNotifier<bool> isDescending = ValueNotifier<bool>(false);
  // final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  // Define the sorting options
  final sortingOptions = [
    'Name',
    'Quantity',
    'Date',
  ];

  String sortByOption = "Name";
  DateTime nearestExpDate = DateTime.now();
  int expItemCount = 0;
  String itemName = "";
  int quantity = 0;
  List<ItemResponseObject> feItemList = [];
  List<ItemResponseObject> freshItemList = [];
  DateTime datePurchased = DateTime(2022, 12, 10);
  DateTime dateExpiresOn = DateTime(2022, 12, 15);

  HomePageState(this.context) {
    loadItems();
    getCardDisplayInfo();
  }
  void toggleSortingOrder() {
    isDescending.value = !isDescending.value;
    notifyListeners();
  }

  // void toggleLoading() {
  //   isLoading.value = !isLoading.value;
  //   notifyListeners();
  // }

  List<ItemResponseObject> sortItems(
      List<ItemResponseObject> items, bool isDescending, String sortBy) {
    switch (sortBy) {
      case 'Name':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.itemName!.compareTo(item1.itemName!)
              : item1.itemName!.compareTo(item2.itemName!));
      case 'Quantity':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.quantity!.compareTo(item1.quantity!)
              : item1.quantity!.compareTo(item2.quantity!));
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
    loadSortingOptions(context, sortingOptions).then((selectedOption) {
      handleSortingOptionSelected(selectedOption);
    });
  }

  void handleSortingOptionSelected(String? selectedOption) {
    if (selectedOption != null) {
      sortByOption = selectedOption;
      sortItems(
        feItemList,
        isDescending.value,
        selectedOption,
      );
      notifyListeners();
    }
  }

  Future<List<ItemResponseObject>> reloadItems() async {
    try {
      List<ItemResponseObject> items = await _itemService.getAllItems();
      return items;
    } catch (error) {
      print('Error loading items: $error');
      throw error; // Rethrow the error to be handled by the caller
    }
  }

  Future<void> loadItems() async {
    try {
      List<ItemResponseObject> items = await _itemService.getAllItems();
      feItemList = items;
      notifyListeners();
    } catch (error) {
      print('Error loading items: $error');
    }
  }

  Future<void> deleteItem(int itemID) async {
    await _itemService.deleteItem(itemID);
    await loadItems();
    await getCardDisplayInfo();
  }

  Future<void> getCardDisplayInfo() async {
    try {
      List<ItemResponseObject> items = await _itemService.getFreshItems();
      freshItemList = items;
      expItemCount = freshItemList.length;

      // Find the item closest to its expiry date
      DateTime now = DateTime.now();
      nearestExpDate = freshItemList
          .map((item) => item.dateExpiresOn!)
          .where((date) => date.isAfter(now))
          .reduce((a, b) => a.isBefore(b) ? a : b);

      notifyListeners();
    } catch (error) {
      print('Error loading items: $error');
    }
  }
}
