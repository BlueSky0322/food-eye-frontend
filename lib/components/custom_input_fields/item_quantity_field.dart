import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_input_decoration/input_decoration_additem.dart';

class ItemQuantityFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final String? initialValue;

  const ItemQuantityFormField({
    super.key,
    this.initialValue,
    this.validator,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number, // Updated keyboardType
      decoration: AddItemInputDecoration.addItemInputDecoration(
        hintText: "Enter the quantity",
        labelText: "Quantity", // Updated labelText
        prefixIcon: Icons.shopping_basket_outlined, // Updated prefixIcon
        suffixIcon: null,
      ),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
    );
  }
}
