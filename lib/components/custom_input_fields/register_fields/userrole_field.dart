import 'package:flutter/material.dart';
import '../../custom_input_decoration/input_decoration_landing.dart';

class UserRoleFormField extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const UserRoleFormField({
    super.key,
    required this.onChanged,
    this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      dropdownColor: const Color.fromARGB(255, 20, 65, 102),
      decoration: LandingPagesInputDecoration.inputDecoration(
        hintText: "Select User Role",
        labelText: "Register As",
        prefixIcon: Icons.supervised_user_circle_sharp,
        suffixIcon: null,
      ),
      style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      items: const [
        DropdownMenuItem<String>(
          value: 'Seller',
          child: Text('Seller'),
        ),
        DropdownMenuItem<String>(
          value: 'Customer',
          child: Text('Customer'),
        ),
      ],
      onChanged: onChanged,
      value: initialValue,
    );
  }
}
