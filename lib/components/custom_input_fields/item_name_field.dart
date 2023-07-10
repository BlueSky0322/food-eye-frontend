import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../custom_input_decoration/input_decoration_additem.dart';

class ItemNameFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;

  const ItemNameFormField({
    super.key,
    this.validator,
    this.onPressed,
    this.initialValue,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: TextInputType.text,
      decoration: AddItemInputDecoration.addItemInputDecoration(
        hintText: "Enter the item name",
        labelText: "Item Name",
        prefixIcon: Icons.fastfood_outlined,
        suffixIcon: IconButton(
          icon: const Icon(Icons.document_scanner),
          color: primaryBG,
          onPressed: onPressed,
        ),
      ),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
      controller: controller,
      initialValue: initialValue,
    );
  }
}
