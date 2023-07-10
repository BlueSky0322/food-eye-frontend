import 'package:flutter/material.dart';

import '../custom_input_decoration/input_decoration_additem.dart';

class ItemTypeFormField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const ItemTypeFormField({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      value: initialValue,
      decoration: AddItemInputDecoration.addItemInputDecoration(
        hintText: "Select Type",
        labelText: "Item Type",
        prefixIcon: Icons.category_outlined,
        suffixIcon: null,
      ),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      items: const [
        DropdownMenuItem<String>(
          value: 'Fresh Produce',
          child: Text('Fresh Produce'),
        ),
        DropdownMenuItem<String>(
          value: 'Meat and Seafood',
          child: Text('Meat and Seafood'),
        ),
        DropdownMenuItem<String>(
          value: 'Refrigerated',
          child: Text('Refrigerated'),
        ),
        DropdownMenuItem<String>(
          value: 'Snack Foods',
          child: Text('Snack Foods'),
        ),
        DropdownMenuItem<String>(
          value: 'Canned Goods',
          child: Text('Canned Goods'),
        ),
        DropdownMenuItem<String>(
          value: 'Non-perishables',
          child: Text('Non-perishables'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
