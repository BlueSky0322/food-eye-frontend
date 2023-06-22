import 'package:flutter/material.dart';

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

  Future<void> login() async {
    // Create an instance of AuthUser
    AuthUser user = AuthUser(email: email, password: password);

    // Call your login API using a service or HTTP client
    // Pass the user credentials and handle the response
    // ...
    if (email == 'a@a.c' && password == '123123') {
      print(email + " " + password);
      notifyListeners();
    }
  }
}
