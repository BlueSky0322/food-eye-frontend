import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/input_decoration_additem.dart';
import '../../../utils/constants.dart';

class DateFormField extends StatelessWidget {
  static const _100_YEARS = Duration(days: 365 * 100);
  final ValueChanged<String> onChanged;
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;
  final IconData? prefixicon;
  //final DateTime? currentValue;
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  DateFormField({
    required this.onChanged,
    required this.onPressed,
    required this.controller,
    //required this.currentValue,
    this.validator,
    required this.labelText,
    required this.hintText,
    required this.prefixicon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        //initialValue: DateFormat('dd/MM/yyyy').format(currentValue!),
        readOnly: true,
        validator: validator,
        decoration: AddItemInputDecoration.addItemInputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixicon,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            color: primaryBG,
            onPressed: onPressed,
          ),
        ),
        style: TextStyle(
            color: Colors.teal.shade800,
            fontSize: 16,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w500),
        controller: controller,
        onChanged: onChanged);
  }
}
