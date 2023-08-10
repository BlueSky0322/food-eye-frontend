import 'dart:convert';
import 'dart:developer';

import 'package:food_eye_fyp/data/request_response_model/add_product_request.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_product_response.dart';
import 'package:food_eye_fyp/data/request_response_model/product_response.dart';
import 'package:food_eye_fyp/data/request_response_model/update_product_request.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:food_eye_fyp/utils/http_overrides.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final client = Client();

  Future<List<CustProductResponse>> custGetAllProducts() async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Product/CustomerGetAllProducts"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<CustProductResponse> products = responseData
            .map((data) => CustProductResponse.fromJson(data))
            .toList();
        return products;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting items: $error');
      return [];
    }
  }

  Future<List<ProductResponse>> getAllProducts(String? userId) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Product/GetAllProducts/$userId"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<ProductResponse> products =
            responseData.map((data) => ProductResponse.fromJson(data)).toList();
        return products;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error getting items: $error');
      return [];
    }
  }

  Future<ProductResponse> getItemByID(int productID) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/Product/GetProductByID/$productID"),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ProductResponse product = ProductResponse.fromJson(responseData);
        // log(item);
        return product;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        // return null;
      }
    } catch (error) {
      log('Error getting items: $error');
      // return null;
    }
    return ProductResponse();
  }

  Future<bool> addProduct(AddProductRequest newProduct) async {
    final url = Uri.parse('$apiURL/Product/AddProduct');
    // Convert the AddItemRequest object to JSON
    final jsonData = json.encode(newProduct.toJson());
    try {
      // Create a multipart request
      final request = http.MultipartRequest('POST', url);

      // Check if an image was provided
      if (newProduct.imagePath != null &&
          newProduct.imagePath!.isNotEmpty &&
          newProduct.imagePath != defaultImage) {
        // Add the image file to the request
        final imageFile = await http.MultipartFile.fromPath(
          'productImage',
          newProduct.imagePath!,
        );
        request.files.add(imageFile);
      }

      // Add the JSON data as a field in the multipart request
      request.fields['productData'] = jsonData;

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

  Future<bool> updateProduct(UpdateProductRequest updateProductRequest) async {
    final url = Uri.parse('$apiURL/Product/UpdateProduct');

    try {
      // Create a multipart request
      final request = http.MultipartRequest('PUT', url);

      // Convert the AddItemRequest object to JSON
      final jsonData = json.encode(updateProductRequest.toJson());

      // Check if an image was provided
      if (updateProductRequest.imagePath != null &&
          updateProductRequest.imagePath!.isNotEmpty &&
          !updateProductRequest.imagePath!.startsWith('https://')) {
        // Add the image file to the request
        final imageFile = await http.MultipartFile.fromPath(
          'productImage',
          updateProductRequest.imagePath!,
        );

        request.files.add(imageFile);
      }

      // Add the JSON data as a field in the multipart request
      request.fields['productData'] = jsonData;

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

  Future<void> deleteProduct(int productID) async {
    final apiUrl = '$apiURL/Product/DeleteProduct/$productID';
    final response = await client.delete(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 204) {
        // Deletion successful
        log('Product deleted successfully');
      } else {
        log('API call failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      log('Error deleting product. Error message: $error');
    }
  }
}
