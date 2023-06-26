import 'package:flutter/material.dart';

import '../../../components/input_decoration_additem.dart';

class ItemTypeFormField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? currentValue;

  const ItemTypeFormField({
    Key? key,
    required this.onChanged,
    required this.currentValue,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      value: currentValue,
      decoration: AddItemInputDecoration.addItemInputDecoration(
        hintText: "Select Type",
        labelText: "Item Type",
        prefixIcon: Icons.category_outlined,
        suffixIcon: null,
      ),
      style: TextStyle(
          color: Colors.teal.shade600,
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
          value: 'Dairy and Refrigerated',
          child: Text('Refrigerated'),
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
