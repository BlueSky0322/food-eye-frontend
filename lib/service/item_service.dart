import 'dart:convert';

import 'package:http/http.dart';

import '../data/model/item_response.dart';
import '../utils/http_utils.dart';

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
        print(items);
        return items;
      } else {
        print('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error getting items: $error');
      return [];
    }
  }

  Future<ItemResponseObject?> getItemByID(int itemID) async {
    try {
      final response = await client.get(
        Uri.parse("$usbDebugURL/api/FoodEyeItems/GetItemByID/$itemID"),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ItemResponseObject item =
            responseData.map((data) => ItemResponseObject.fromJson(data));
        print(item);
        return item;
      } else {
        print('API call failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error getting items: $error');
      return null;
    }
  }

  Future<void> deleteItem(int itemID) async {
    final apiUrl = '$usbDebugURL/api/FoodEyeItems/DeleteFEItem/$itemID';
    final response = await client.delete(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 204) {
        // Deletion successful
        print('Item deleted successfully');
      } else {
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting item. Error message: $error');
    }
  }
}
