import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class AddItemInputDecoration {
  static InputDecoration addItemInputDecoration({
    required String hintText,
    required String labelText,
    required IconData? prefixIcon,
    required Widget? suffixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryBG),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: addItemField),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: primaryBG,
      ),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Outfit',
        color: Color.fromARGB(255, 128, 167, 199),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Outfit',
        color: addItemField,
      ),
      errorStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Outfit',
        color: Colors.redAccent,
      ),
    );
  }
}
