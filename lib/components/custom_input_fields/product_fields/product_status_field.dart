import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_decoration/input_decoration_main.dart';

class ProductStatusFormField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const ProductStatusFormField({
    super.key,
    required this.onChanged,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      borderRadius: BorderRadius.circular(8),
      decoration: MainInputDecoration.inputDecoration(
        hintText: "Select Product Status",
        labelText: "Status",
        prefixIcon: Icons.stacked_bar_chart,
        suffixIcon: null,
      ),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      items: const [
        DropdownMenuItem<String>(
          value: 'Coming Soon',
          child: Text('Coming Soon'),
        ),
        DropdownMenuItem<String>(
          value: 'On Sale',
          child: Text('On Sale'),
        ),
        DropdownMenuItem<String>(
          value: 'Ending Soon',
          child: Text('Ending Soon'),
        ),
      ],
      onChanged: onChanged,
      value: initialValue,
    );
  }
}
