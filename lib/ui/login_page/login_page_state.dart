import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/model/user.dart';

import '../../data/model/auth_user.dart';

class LoginPageState extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  String email = '';
  String password = '';
  LoginPageState(this.context);

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
    // Create an instance of AuthUser
    AuthUser user = AuthUser(email: email, password: password);
    log("${user.email}:${user.password}");

    // Check if the email and password exist in the list of users
    bool isValidUser = User.userList
        .any((u) => u.email == user.email && u.password == user.password);

    if (isValidUser) {
      notifyListeners();
      return true;
    }

    return null;
  }
}
