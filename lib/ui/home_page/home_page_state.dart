import 'package:flutter/material.dart';
import 'package:food_eye_fyp/service/item_service.dart';
import 'package:food_eye_fyp/ui/home_page/components/show_menu_ui.dart';
import 'package:http/http.dart';

import '../../data/model/item_response.dart';

class HomePageState extends ChangeNotifier {
  final BuildContext context;
  final client = Client();
  final _itemService = ItemService();
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
  String itemName = "";
  int quantity = 0;
  List<ItemResponseObject> feItemList = [];
  DateTime datePurchased = DateTime(2022, 12, 10);
  DateTime dateExpiresOn = DateTime(2022, 12, 15);

  HomePageState(this.context) {
    loadItems();
  }
  void toggleSortingOrder() {
    isDescending.value = !isDescending.value;
    notifyListeners();
  }

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
        feItemList,
        isDescending.value,
        selectedOption,
      );
      notifyListeners();
    }
  }

  Future<void> loadItems() async {
    await _itemService.getAllItems().then((items) {
      feItemList = items;
      notifyListeners();
    });
  }

  Future<void> deleteItem(int itemID) async {
    await _itemService.deleteItem(itemID);
    await loadItems();
    // notifyListeners();
  }
}
