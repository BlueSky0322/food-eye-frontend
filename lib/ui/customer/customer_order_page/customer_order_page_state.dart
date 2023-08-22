import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/sorting_options.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_order_response.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_update_order_request.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/order_service.dart';
import 'package:provider/provider.dart';

class CustOrderPageState extends ChangeNotifier {
  BuildContext context;
  final ValueNotifier<bool> isDescending = ValueNotifier<bool>(false);
  final _orderService = OrderService();
  final sortingOptions = [
    'Seller Name',
    'Order Date',
  ];
  String sortByOption = "Seller Name";
  List<CustOrderResponse> orderList = [];
  late UserProvider userProvider;

  int? orderId;
  int? quantity;
  String? orderDetails;

  CustOrderPageState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadOrders();
  }
  void toggleSortingOrder() {
    isDescending.value = !isDescending.value;
    notifyListeners();
  }

  List<CustOrderResponse> sortItems(
      List<CustOrderResponse> items, bool isDescending, String sortBy) {
    switch (sortBy) {
      case 'Seller Name':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.sellerName.compareTo(item1.sellerName)
              : item1.sellerName.compareTo(item2.sellerName));
      case 'Date':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.orderDate.compareTo(item1.orderDate)
              : item1.orderDate.compareTo(item2.orderDate));
      default:
        break;
    }

    return items;
  }

  void showSortingOptions(BuildContext context) {
    // Show the popup menu
    loadSortingOptions(context, sortingOptions, 1.9, 4.5, 1, 1)
        .then((selectedOption) {
      handleSortingOptionSelected(selectedOption);
    });
  }

  void handleSortingOptionSelected(String? selectedOption) {
    if (selectedOption != null) {
      sortByOption = selectedOption;
      sortItems(
        orderList,
        isDescending.value,
        selectedOption,
      );
      notifyListeners();
    }
  }

  Future<void> loadOrders() async {
    try {
      List<CustOrderResponse> orders =
          await _orderService.custGetAllOrders(userProvider.userId);
      orderList = orders;
      notifyListeners();
    } catch (error) {
      log('Error loading products: $error');
    }
  }

  Future<List<CustOrderResponse>> reloadOrders() async {
    try {
      List<CustOrderResponse> orders =
          await _orderService.custGetAllOrders(userProvider.userId);
      return orders;
    } catch (error) {
      log('Error loading products: $error');
      rethrow;
    }
  }

  Future<void> deleteOrder(int productID) async {
    await _orderService.deleteOrder(productID);
    await loadOrders();
  }

  Future<bool> custUpdateOrder() async {
    orderDetails ??= "No remarks";
    try {
      CustomerUpdateOrderRequest updatedProduct = CustomerUpdateOrderRequest(
        orderId: orderId,
        quantity: quantity,
        orderDetails: orderDetails,
      );

      notifyListeners();
      return await _orderService.custUpdateOrder(updatedProduct);
    } catch (error) {
      log('Error updating item: $error');
      return false;
    }
  }
}
