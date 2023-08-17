import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_eye_fyp/components/custom_input_decoration/input_decoration_main.dart';
import 'package:food_eye_fyp/utils/constants.dart';

class PriceFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String labelText;
  final String hintText;
  final IconData? prefixicon;
  final IconData? suffixIcon;
  final Color? textcolour;
  final TextEditingController controller;

  const PriceFormField({
    super.key,
    this.onPressed,
    this.textcolour,
    this.initialValue,
    required this.validator,
    required this.onChanged,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixicon,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      initialValue: initialValue,
      keyboardType: const TextInputType.numberWithOptions(
          decimal: true), // Updated keyboardType
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: MainInputDecoration.inputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixicon,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          color: primaryBG,
          onPressed: onPressed,
        ),
      ),
      style: TextStyle(
          color: textcolour,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
    );
  }
}
