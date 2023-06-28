import 'package:flutter/material.dart';

import '../../../components/input_decoration_additem.dart';
import '../../../utils/constants.dart';

class ItemNameFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;

  const ItemNameFormField({
    super.key,
    required this.onChanged,
    this.validator,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: TextInputType.text,
      decoration: AddItemInputDecoration.addItemInputDecoration(
        hintText: "Enter the item name",
        labelText: "Item Name",
        prefixIcon: Icons.fastfood_outlined,
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: onTap,
              // child:
              child: const Center(
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ),
          ),
        ),
      ),
      style: TextStyle(
          color: Colors.teal.shade800,
          fontSize: 18,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w500),
      onChanged: onChanged,
      controller: controller,
    );
  }
}
