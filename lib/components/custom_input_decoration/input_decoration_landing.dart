import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class LandingPagesInputDecoration {
  static InputDecoration inputDecoration({
    required String hintText,
    required String labelText,
    required IconData? prefixIcon,
    required IconButton? suffixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryBG),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 84, 229, 240)),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: const Color.fromARGB(255, 96, 180, 206),
      ),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Outfit',
        color: Color.fromARGB(255, 11, 133, 170),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Outfit',
        color: Color.fromARGB(255, 96, 180, 206),
      ),
      errorStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Outfit',
        color: Colors.redAccent,
      ),
    );
  }
}
