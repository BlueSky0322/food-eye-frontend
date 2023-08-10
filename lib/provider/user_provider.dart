import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? userId;
  String? userRole;

  void setUserData(String id, String role) {
    userId = id;
    userRole = role;
    notifyListeners();
  }
}
