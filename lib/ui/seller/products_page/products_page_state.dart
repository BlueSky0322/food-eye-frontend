import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/product_response.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/product_service.dart';
import 'package:food_eye_fyp/ui/seller/products_page/sorting_options_popup/sorting_options.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductsPageState extends ChangeNotifier {
  BuildContext context;
  final ValueNotifier<bool> isDescending = ValueNotifier<bool>(false);
  final _productService = ProductService();
  final sortingOptions = [
    'Name',
    'Price',
    'Shelf Life',
    'Date',
  ];

  String sortByOption = "Name";
  List<ProductResponse> productsList = [];
  late UserProvider userProvider;

  ProductsPageState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadProducts();
  }
  void toggleSortingOrder() {
    isDescending.value = !isDescending.value;
    notifyListeners();
  }

  List<ProductResponse> sortItems(
      List<ProductResponse> items, bool isDescending, String sortBy) {
    switch (sortBy) {
      case 'Name':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.productName!.compareTo(item1.productName!)
              : item1.productName!.compareTo(item2.productName!));
      case 'Price':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.price!.compareTo(item1.price!)
              : item1.price!.compareTo(item2.price!));
      case 'Shelf Life':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.shelfLife!.compareTo(item1.shelfLife!)
              : item1.shelfLife!.compareTo(item2.shelfLife!));
      case 'Date':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.dateAdded!.compareTo(item1.dateAdded!)
              : item1.dateAdded!.compareTo(item2.dateAdded!));
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
        productsList,
        isDescending.value,
        selectedOption,
      );
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    try {
      List<ProductResponse> products =
          await _productService.getAllProducts(userProvider.userId);
      productsList = products;
      notifyListeners();
    } catch (error) {
      log('Error loading products: $error');
    }
  }

  Future<List<ProductResponse>> reloadProducts() async {
    try {
      List<ProductResponse> products =
          await _productService.getAllProducts(userProvider.userId);
      return products;
    } catch (error) {
      log('Error loading products: $error');
      rethrow; // Rethrow the error to be handled by the caller
    }
  }

  Future<void> deleteProduct(int productID) async {
    await _productService.deleteProduct(productID);
    await loadProducts();
  }
}
