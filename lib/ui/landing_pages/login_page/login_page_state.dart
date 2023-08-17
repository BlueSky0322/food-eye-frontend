import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/user_login_response.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/shared_preferences_service.dart';
import 'package:food_eye_fyp/service/user_service.dart';
import 'package:provider/provider.dart';

import '../../../data/request_response_model/user_login_request.dart';

class LoginPageState extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  final _userService = UserService();
  String email = '';
  String password = '';
  late UserProvider userProvider;

  LoginPageState(this.context) {
    // Initialize the UserProvider in the constructor
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  Future<bool?> login() async {
    try {
      // Create an instance of UserLoginRequest
      UserLoginRequest loginRequest = UserLoginRequest(
        email: email,
        password: password,
      );
      UserLoginResponse? loginResponse = await _userService.login(loginRequest);
      if (loginResponse != null) {
        // Set the userId in the UserProvider
        userProvider.setUserData(loginResponse.userId, loginResponse.userRole);
        await SharedPrefsService.saveUserId(loginResponse.userId);
        log("${userProvider.userId} + ${userProvider.userRole}");
        notifyListeners();
        return true;
      }
      return false;
    } catch (error) {
      log('Error logging in: $error');
      return false;
    }
  }
}
