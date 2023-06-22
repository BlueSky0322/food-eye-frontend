import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.labelText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryBG),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 84, 229, 240)),
            ),
            fillColor: Color.fromARGB(255, 45, 84, 116),
            filled: false,
            prefixIcon: Icon(
              prefixIcon,
              color: Color.fromARGB(255, 96, 180, 206),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 11, 133, 170),
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 96, 180, 206),
            )),
      ),
    );
  }
}
