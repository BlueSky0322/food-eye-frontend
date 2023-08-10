import 'dart:convert';
import 'dart:developer';

import 'package:food_eye_fyp/data/request_response_model/add_order_request.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_order_response.dart';
import 'package:food_eye_fyp/data/request_response_model/seller_order_response.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_update_order_request.dart';
import 'package:food_eye_fyp/data/request_response_model/seller_update_order_request.dart';
import 'package:food_eye_fyp/utils/http_overrides.dart';
import 'package:http/http.dart';

class OrderService {
  final client = Client();
  Future<List<CustOrderResponse>> custGetAllOrders(String? userId) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Order/CustomerGetAllOrders/$userId"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<CustOrderResponse> products = responseData
            .map((data) => CustOrderResponse.fromJson(data))
            .toList();
        return products;
      } else {
        log('custGetAllOrders API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting orders: $error');
      return [];
    }
  }

  Future<List<SellerOrderResponse>> sellerGetAllOrders(String? userId) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Order/SellerGetAllOrders/$userId"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<SellerOrderResponse> orders = responseData
            .map((data) => SellerOrderResponse.fromJson(data))
            .toList();
        return orders;
      } else {
        log('sellerGetAllOrders API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting orders: $error');
      return [];
    }
  }

  Future<bool> addOrder(AddOrderRequest newOrder) async {
    final url = Uri.parse('$apiURL/Order/AddOrder');

    try {
      final jsonData = json.encode(newOrder.toJson());
      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );
      if (response.statusCode == 201) {
        log('Order added successfully!');
        return true;
      } else {
        log('addOrder API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error adding items: $error');
      return false;
    }
  }

  Future<bool> custUpdateOrder(
      CustomerUpdateOrderRequest updateOrderRequest) async {
    final url = Uri.parse('$apiURL/Order/CustomerUpdateOrder');

    try {
      final jsonData = json.encode(updateOrderRequest.toJson());
      final response = await client.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );
      if (response.statusCode == 200) {
        log('Order updated successfully!');
        return true;
      } else {
        log('updateOrder API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error updating order: $error');
      return false;
    }
  }

  Future<bool> sellerUpdateOrder(
      SellerUpdateOrderRequest updateOrderRequest) async {
    final url = Uri.parse('$apiURL/Order/SellerUpdateOrder');

    try {
      final jsonData = json.encode(updateOrderRequest.toJson());
      final response = await client.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );
      if (response.statusCode == 200) {
        log('Order updated successfully!');
        return true;
      } else {
        log('sellerUpdateOrder API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error updating order: $error');
      return false;
    }
  }

  Future<void> deleteOrder(int orderId) async {
    final apiUrl = '$apiURL/Order/DeleteOrder/$orderId';
    final response = await client.delete(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 200) {
        // Deletion successful
        log('Order deleted successfully');
      } else {
        log('deleteOrder API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error deleting item. Error message: $error');
    }
  }
}
