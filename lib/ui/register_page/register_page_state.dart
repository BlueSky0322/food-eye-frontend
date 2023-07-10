import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/model/new_user.dart';

class RegisterPageState extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  String email = '';
  String password = '';
  String name = '';
  int age = 0;
  DateTime? dateOfBirth;
  String address = '';

  List<NewUser> newUserList = [];

  RegisterPageState(this.context);

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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    bool isAlphabetic = RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);

    if (!isAlphabetic) {
      return 'Please enter alphabetic characters only';
    }

    return null;
  }

  String? validateAge(int? value) {
    if (value == null) {
      return 'Field cannot be blank';
    } else if (value <= 0 || value > 100) {
      return 'Please enter a valid age between 0 and 100';
    }

    return null;
  }

  String? validateDob(DateTime? value) {
    if (value == null) {
      return 'Field cannot be blank';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    return null;
  }

  bool register() {
    NewUser newUser = NewUser(
        email: email,
        password: password,
        name: name,
        age: age,
        address: address,
        dateOfBirth: dateOfBirth);

    NewUser.users.add(newUser);
    log(newUserList.toString());
    log("${newUser.email}");
    log("${newUser.password}");
    log("${newUser.age}");
    log("${newUser.address}");
    log("${newUser.dateOfBirth}");
    notifyListeners();
    return true;
  }
}
