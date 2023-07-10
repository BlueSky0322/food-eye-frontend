import 'package:flutter/material.dart';
import '../custom_input_decoration/input_decoration_additem.dart';

class ItemDescFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final TextEditingController controller;

  const ItemDescFormField({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: AddItemInputDecoration.addItemInputDecoration(
          hintText: "Something additional to say",
          labelText: "Item Description",
          prefixIcon: Icons.pending_outlined,
          suffixIcon: null),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
      initialValue: initialValue,
      controller: controller,
    );
  }
}
