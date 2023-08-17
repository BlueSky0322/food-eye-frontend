import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/sorting_options.dart';
import 'package:food_eye_fyp/data/request_response_model/seller_order_response.dart';
import 'package:food_eye_fyp/data/request_response_model/seller_update_order_request.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/order_service.dart';
import 'package:provider/provider.dart';

class OrdersPageState extends ChangeNotifier {
  BuildContext context;
  final ValueNotifier<bool> isDescending = ValueNotifier<bool>(false);
  final _orderService = OrderService();
  final sortingOptions = [
    'Cust Name',
    'Order Date',
  ];
  String sortByOption = "Cust Name";
  List<SellerOrderResponse> orderList = [];
  late UserProvider userProvider;

  int? orderId;
  String? orderStatus;

  OrdersPageState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadOrders();
  }

  String? validateIfEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }
    return null;
  }

  void toggleSortingOrder() {
    isDescending.value = !isDescending.value;
    notifyListeners();
  }

  List<SellerOrderResponse> sortItems(
      List<SellerOrderResponse> items, bool isDescending, String sortBy) {
    switch (sortBy) {
      case 'Cust Name':
        return items
          ..sort((item1, item2) => isDescending
              ? item2.userName.compareTo(item1.userName)
              : item1.userName.compareTo(item2.userName));
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
      List<SellerOrderResponse> orders =
          await _orderService.sellerGetAllOrders(userProvider.userId);
      orderList = orders;
      notifyListeners();
    } catch (error) {
      log('Error loading products: $error');
    }
  }

  Future<List<SellerOrderResponse>> reloadOrders() async {
    try {
      List<SellerOrderResponse> orders =
          await _orderService.sellerGetAllOrders(userProvider.userId);
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

  Future<bool> sellerUpdateOrder() async {
    try {
      SellerUpdateOrderRequest updatedOrder = SellerUpdateOrderRequest(
        orderId: orderId,
        orderStatus: orderStatus,
      );
      log("${updatedOrder.orderId} ${updatedOrder.orderStatus}");
      notifyListeners();
      return await _orderService.sellerUpdateOrder(updatedOrder);
    } catch (error) {
      log('Error updating item: $error');
      return false;
    }
  }
}
