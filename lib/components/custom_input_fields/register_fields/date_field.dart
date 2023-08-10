import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_decoration/input_decoration_landing.dart';

class DateFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;
  final IconData? prefixicon;
  final IconData? suffixIcon;
  final String? initialValue;
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const DateFormField({
    super.key,
    this.initialValue,
    this.validator,
    required this.onChanged,
    required this.onPressed,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixicon,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: true,
      validator: validator,
      decoration: LandingPagesInputDecoration.inputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixicon,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          color: const Color.fromARGB(255, 96, 180, 206),
          onPressed: onPressed,
        ),
      ),
      style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
