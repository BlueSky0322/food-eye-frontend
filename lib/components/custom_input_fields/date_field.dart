import 'package:flutter/material.dart';
import '../custom_input_decoration/input_decoration_additem.dart';
import '../../../../utils/constants.dart';

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
    required this.onChanged,
    required this.onPressed,
    required this.controller,
    this.initialValue,
    this.validator,
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
      decoration: AddItemInputDecoration.addItemInputDecoration(
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
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
