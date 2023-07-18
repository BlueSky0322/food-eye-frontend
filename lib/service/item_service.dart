import 'dart:convert';
import 'dart:developer';

import 'package:food_eye_fyp/data/model/item.dart';
import 'package:http/http.dart';

import '../data/model/item_response.dart';
import '../utils/http_overrides.dart';

class ItemService {
  final client = Client();

  Future<List<ItemResponseObject>> getAllItems() async {
    try {
      final response = await client.get(
        Uri.parse("$usbDebugURL/api/FoodEyeItems/GetAllItems"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ItemResponseObject> items = responseData
            .map((data) => ItemResponseObject.fromJson(data))
            .toList();
        return items;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting items: $error');
      return [];
    }
  }

  Future<List<ItemResponseObject>> getItemsExpiringWithin(int days) async {
    try {
      final response = await client.get(
        Uri.parse('$usbDebugURL/api/FoodEyeItems/GetItemsExpiringWithin/$days'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ItemResponseObject> items = responseData
            .map((data) => ItemResponseObject.fromJson(data))
            .toList();
        return items;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting items: $error');
      return [];
    }
  }

  Future<List<ItemResponseObject>> getFreshItems() async {
    try {
      final response = await client.get(
        Uri.parse('$usbDebugURL/api/FoodEyeItems/GetFreshItems'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ItemResponseObject> items = responseData
            .map((data) => ItemResponseObject.fromJson(data))
            .toList();
        return items;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting items: $error');
      return [];
    }
  }

  Future<ItemResponseObject> getItemByID(int itemID) async {
    print("Entered getitembyid");
    try {
      final response = await client.get(
        Uri.parse("$usbDebugURL/api/FoodEyeItems/GetItemByID/$itemID"),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ItemResponseObject item = ItemResponseObject.fromJson(responseData);
        // log(item);
        return item;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        // return null;
      }
    } catch (error) {
      log('Error getting items: $error');
      // return null;
    }
    return ItemResponseObject();
  }

  Future<void> deleteItem(int itemID) async {
    final apiUrl = '$usbDebugURL/api/FoodEyeItems/DeleteFEItem/$itemID';
    final response = await client.delete(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 204) {
        // Deletion successful
        log('Item deleted successfully');
      } else {
        log('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error deleting item. Error message: $error');
    }
  }

  Future<bool> updateItem(int id, Item updatedItem) async {
    final url = Uri.parse('$usbDebugURL/api/FoodEyeItems/UpdateFEItem/$id');

    try {
      // Convert the updatedItem object to JSON
      final jsonData = json.encode(updatedItem.toJson());

      // Make the PUT request
      final response = await client.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 204) {
        log('Item updated successfully!');
        return true;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error updating item: $error');
      return false;
    }
  }

  Future<bool> addItem(Item newItem) async {
    final url = Uri.parse('$usbDebugURL/api/FoodEyeItems/AddFEItem');

    try {
      // Convert the updatedItem object to JSON
      final jsonData = json.encode(newItem.toJson());

      // Make the PUT request
      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 201) {
        log('Item updated successfully!');
        return true;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error updating item: $error');
      return false;
    }
  }
}
