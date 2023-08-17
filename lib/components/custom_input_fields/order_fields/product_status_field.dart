import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_decoration/input_decoration_main.dart';

class OrderStatusFormField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const OrderStatusFormField({
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
        hintText: "Update Order Status",
        labelText: "Order Status",
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
          value: 'Delivering',
          child: Text('Delivering'),
        ),
        DropdownMenuItem<String>(
          value: 'Cancelled',
          child: Text('Cancelled'),
        ),
        DropdownMenuItem<String>(
          value: 'Notified',
          child: Text('Notified'),
        ),
        DropdownMenuItem<String>(
          value: 'Pending',
          child: Text('Pending'),
        ),
      ],
      onChanged: onChanged,
      value: initialValue,
    );
  }
}
