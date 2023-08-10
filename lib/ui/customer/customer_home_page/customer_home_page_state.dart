import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/add_order_request.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_product_response.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/order_service.dart';
import 'package:food_eye_fyp/service/product_service.dart';
import 'package:food_eye_fyp/service/user_service.dart';
import 'package:provider/provider.dart';

class CustomerHomePageState extends ChangeNotifier {
  BuildContext context;
  String userEmail = "loading";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UserProvider userProvider;
  CustomerHomePageState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadProducts();
    getEmail();
  }

  final _productService = ProductService();
  final _userService = UserService();
  final _orderService = OrderService();

  TextEditingController orderDetailsController = TextEditingController();
  int? productId;
  String? userId;
  int? quantity;
  DateTime? orderDate;
  String orderDetails = "No remarks";

  List<CustProductResponse> productsList = [];

  Future<void> loadProducts() async {
    List<CustProductResponse> products =
        await _productService.custGetAllProducts();
    productsList = products;
    log("${productsList.length} products total");
    notifyListeners();
  }

  Future<List<CustProductResponse>> reloadProducts() async {
    List<CustProductResponse> products =
        await _productService.custGetAllProducts();
    log("products page reloading");
    return products;
  }

  Future<void> getEmail() async {
    final email = await _userService.getEmail(userProvider.userId);
    userEmail = email!;
    notifyListeners();
  }

  Future<bool> addOrder() async {
    AddOrderRequest newOrder = AddOrderRequest(
      productId: productId,
      userId: userProvider.userId,
      quantity: quantity,
      orderDate: DateTime.now(),
      orderDetails: orderDetails,
    );
    log("${newOrder.productId}");
    log("${newOrder.userId}");
    log("${newOrder.quantity}");
    log("${newOrder.orderDate}");
    log(newOrder.orderStatus);
    log(newOrder.orderDetails);
    return await _orderService.addOrder(newOrder);
    // return true;
  }
}
