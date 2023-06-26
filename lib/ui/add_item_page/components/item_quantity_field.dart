import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/input_decoration_additem.dart';

class ItemQuantityFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final String? currentValue;

  const ItemQuantityFormField({
    super.key,
    required this.onChanged,
    this.validator,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: currentValue,
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
          fontSize: 18,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
    );
  }
}
