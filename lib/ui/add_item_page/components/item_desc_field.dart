import 'package:flutter/material.dart';

import '../../../components/input_decoration_additem.dart';

class ItemDescFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const ItemDescFormField({
    super.key,
    required this.onChanged,
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
          fontSize: 18,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
    );
  }
}
