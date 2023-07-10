import 'package:flutter/material.dart';

import '../custom_input_decoration/input_decoration_additem.dart';

class ItemStorageFormField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const ItemStorageFormField({
    super.key,
    required this.onChanged,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      decoration: AddItemInputDecoration.addItemInputDecoration(
        hintText: "Select Storage Location",
        labelText: "Stored at",
        prefixIcon: Icons.storage_outlined,
        suffixIcon: null,
      ),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      items: const [
        DropdownMenuItem<String>(
          value: 'Pantry',
          child: Text('Pantry'),
        ),
        DropdownMenuItem<String>(
          value: 'Fridge',
          child: Text('Fridge'),
        ),
        DropdownMenuItem<String>(
          value: 'Cupboard',
          child: Text('Cupboard'),
        ),
      ],
      onChanged: onChanged,
      value: initialValue,
    );
  }
}
