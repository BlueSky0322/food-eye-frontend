import 'package:flutter/material.dart';

class GetColorHelper {
  static Color getColorByStatus(String status) {
    switch (status) {
      case 'On Sale':
        return Colors.green;
      case 'Ending Soon':
        return Colors.red;
      case 'Coming Soon':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
