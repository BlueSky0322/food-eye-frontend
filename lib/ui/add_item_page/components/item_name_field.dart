import 'package:flutter/material.dart';

import '../../../components/input_decoration_additem.dart';

class ItemNameFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? currentValue;

  const ItemNameFormField({
    super.key,
    required this.onChanged,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: currentValue,
      keyboardType: TextInputType.text,
      decoration: AddItemInputDecoration.addItemInputDecoration(
          hintText: "Enter the item name",
          labelText: "Item Name",
          prefixIcon: Icons.fastfood_outlined,
          suffixIcon: null),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 18,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
    );
  }
}
