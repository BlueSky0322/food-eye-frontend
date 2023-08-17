import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/user.dart';
import 'package:food_eye_fyp/service/user_service.dart';
import 'package:intl/intl.dart';

class RegisterPageState extends ChangeNotifier {
  BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  final _userService = UserService();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String email = '';
  String password = '';
  String name = '';
  int age = 0;
  DateTime? dateOfBirth;
  String address = '';
  String userRole = '';

  RegisterPageState(this.context);

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateIfEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }
    return null;
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

  String? validateDate(DateTime? value) {
    if (value == null) {
      return 'Field cannot be blank';
    }
    return null;
  }

  Future<void> selectAndAssignDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      dateOfBirth = selectedDate;
      dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  Future<bool?> register() async {
    try {
      User newUser = User(
        email: email,
        password: password,
        name: name,
        age: age,
        address: address,
        dateOfBirth: dateOfBirth,
        userRole: userRole,
      );

      // bool isSuccess = await _userService.register();
      bool isSuccess = await _userService.register(newUser);
      if (isSuccess) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (error) {
      log('Error creating user: $error');
      return false;
    }
  }

  // bool register() {
  //   // Check if email or password already exists
  //   bool isEmailExist = User.userList.any((user) => user.email == email);
  //   bool isPasswordExist =
  //       User.userList.any((user) => user.password == password);

  //   if (isEmailExist) {
  //     log("Email already exists");
  //     return false;
  //   }

  //   if (isPasswordExist) {
  //     log("Password already exists");
  //     return false;
  //   }

  //   User newUser = User(
  //       email: email,
  //       password: password,
  //       name: name,
  //       age: age,
  //       address: address,
  //       dateOfBirth: dateOfBirth);

  //   User.userList.add(newUser);
  //   log(newUserList.toString());
  //   log("${newUser.email}");
  //   log("${newUser.password}");
  //   log("${newUser.age}");
  //   log("${newUser.address}");
  //   log("${newUser.dateOfBirth}");
  //   notifyListeners();
  //   return true;
  // }
}
