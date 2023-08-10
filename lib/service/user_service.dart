import 'dart:convert';
import 'dart:developer';

import 'package:food_eye_fyp/data/request_response_model/user_login_request.dart';
import 'package:food_eye_fyp/data/request_response_model/user_login_response.dart';
import 'package:food_eye_fyp/data/user.dart';
import 'package:http/http.dart';

import '../utils/http_overrides.dart';

class UserService {
  final client = Client();

  Future<String?> getEmail(String? userId) async {
    try {
      final response = await client.get(
        Uri.parse("$apiURL/User/GetEmail/$userId"),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['email'];
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      log('Error getting items: $error');
      return null;
    }
  }

  Future<UserLoginResponse?> login(UserLoginRequest loginRequest) async {
    final url = Uri.parse('$apiURL/User/Login');

    try {
      final jsonData = json.encode(loginRequest.toJson());

      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return UserLoginResponse.fromJson(responseData);
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      log('Error logging in: $error');
      return null;
    }
  }

  Future<bool> register1() async {
    final url = Uri.parse('$apiURL/Test/Test');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      String str = response.body; // This will return the received string
      if (str.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to get name');
    }
  }

  Future<bool> register(User newUser) async {
    final url = Uri.parse('$apiURL/User/Register');

    try {
      final jsonData = json.encode(newUser.toJson());

      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        log('User created successfully');
        return true;
      } else {
        log('API call failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log('Error creating user: $error');
      return false;
    }
  }
}
