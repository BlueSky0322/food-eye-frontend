import 'dart:convert';
import 'dart:developer';

import 'package:food_eye_fyp/data/request_response_model/add_item_request.dart';
import 'package:food_eye_fyp/data/request_response_model/update_item_request.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../data/request_response_model/item_response.dart';
import '../utils/http_overrides.dart';

class ItemService {
  final client = Client();

  Future<List<ItemResponse>> getAllItems(String? userId) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Item/GetAllItems/$userId"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ItemResponse> items =
            responseData.map((data) => ItemResponse.fromJson(data)).toList();
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

  Future<List<ItemResponse>> getItemsExpiringWithin(
      int days, String? userId) async {
    try {
      final response = await client.get(
        Uri.parse('$apiURL/Item/GetItemsExpiringWithin/$days/$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ItemResponse> items =
            responseData.map((data) => ItemResponse.fromJson(data)).toList();
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

  Future<List<ItemResponse>> getFreshItems(String? userId) async {
    try {
      final response = await client.get(
        Uri.parse('$apiURL/Item/GetFreshItems/$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ItemResponse> items =
            responseData.map((data) => ItemResponse.fromJson(data)).toList();
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

  Future<ItemResponse> getItemByID(int itemID) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Item/GetItemByID/$itemID"),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ItemResponse item = ItemResponse.fromJson(responseData);
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
    return ItemResponse();
  }

  Future<void> deleteItem(int itemID) async {
    final apiUrl = '$apiURL/Item/DeleteItem/$itemID';
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

  Future<bool> standardUpdateItem(UpdateItemRequest updateItemRequest) async {
    final url = Uri.parse('$apiURL/Item/StandardUpdateItem');

    try {
      // Convert the updatedItem object to JSON
      final jsonData = json.encode(updateItemRequest.toJson());

      // Make the PUT request
      final response = await client.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        log('Item updated successfully!');
        return true;
      } else {
        log('SUI API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error updating item: $error');
      return false;
    }
  }

  Future<bool> addItem(AddItemRequest newItem) async {
    final url = Uri.parse('$apiURL/Item/AddItem');
    // Convert the AddItemRequest object to JSON
    final jsonData = json.encode(newItem.toJson());
    try {
      // Create a multipart request
      final request = http.MultipartRequest('POST', url);

      // Check if an image was provided
      if (newItem.imagePath != null &&
          newItem.imagePath!.isNotEmpty &&
          newItem.imagePath != defaultImage) {
        // Add the image file to the request
        final imageFile = await http.MultipartFile.fromPath(
          'itemImage',
          newItem.imagePath!,
        );
        request.files.add(imageFile);
      }

      // Add the JSON data as a field in the multipart request
      request.fields['itemData'] = jsonData;

      final response = await request.send();

      if (response.statusCode == 201) {
        log('Item added successfully!');
        return true;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return false;
      }

      // Send the multipart request and wait for the response
    } catch (error) {
      log('Error adding item: $error');
      return false;
    }
  }

  Future<bool> updateItem(UpdateItemRequest updateItemRequest) async {
    final url = Uri.parse('$apiURL/Item/UpdateItem');

    try {
      // Create a multipart request
      final request = http.MultipartRequest('PUT', url);

      // Convert the AddItemRequest object to JSON
      final jsonData = json.encode(updateItemRequest.toJson());

      // Check if an image was provided
      if (updateItemRequest.imagePath != null &&
          updateItemRequest.imagePath!.isNotEmpty &&
          !updateItemRequest.imagePath!.startsWith('https://')) {
        // Add the image file to the request
        final imageFile = await http.MultipartFile.fromPath(
          'itemImage',
          updateItemRequest.imagePath!,
        );

        request.files.add(imageFile);
      }

      // Add the JSON data as a field in the multipart request
      request.fields['itemData'] = jsonData;

      // Send the multipart request and wait for the response
      final response = await request.send();

      if (response.statusCode == 200) {
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
