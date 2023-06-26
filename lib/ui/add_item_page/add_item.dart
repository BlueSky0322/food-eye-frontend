import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/ui/add_item_page/components/date_field.dart';
import 'package:food_eye_fyp/ui/add_item_page/add_item_state.dart';
import 'package:food_eye_fyp/ui/add_item_page/components/item_desc_field.dart';
import 'package:food_eye_fyp/ui/add_item_page/components/item_image.dart';
import 'package:food_eye_fyp/ui/add_item_page/components/item_quantity_field.dart';
import 'package:food_eye_fyp/ui/add_item_page/components/item_storage_field.dart';
import 'package:food_eye_fyp/ui/add_item_page/components/item_type_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'components/item_name_field.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddItemState>(context);
    final ImagePicker picker = ImagePicker();
    XFile? imageFile;
    TextEditingController purchasedDateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    TextEditingController expiryDateController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          "Add new item",
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: primaryBG,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 20),
              child: Column(
                children: [
                  Form(
                    key: state.formKey,
                    child: Column(
                      children: [
                        ItemImage(
                          pickedImage: state.imageFile != null
                              ? Image.file(
                                  File(state.imageFile!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/image-placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                          onPressedGallery: () async {
                            state.selectPhoto(ImageSource.gallery, picker);
                          },
                          onPressedPhoto: () {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemNameFormField(
                            onChanged: (s) => state.itemName = s,
                            currentValue: state.itemName),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemTypeFormField(
                          onChanged: (s) => state.itemType = s,
                          currentValue: state.itemType,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemQuantityFormField(
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
                              int quantity = int.parse(value);
                              state.quantity = quantity;
                            } else {
                              return;
                            }
                          },
                          currentValue: state.quantity.toString(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DateFormField(
                          controller: purchasedDateController,
                          onChanged: (String value) {
                            state.datePurchased = DateTime.parse(value);
                          },
                          onPressed: () async {
                            final selectedDate =
                                await state.selectDate(context, 0);
                            if (selectedDate != null) {
                              // Update the value or perform any necessary actions
                              state.datePurchased = selectedDate;
                              purchasedDateController.text =
                                  DateFormat('dd/MM/yyyy').format(selectedDate);
                            }
                          },
                          //currentValue: state.datePurchased,
                          validator: (value) {
                            final selectedDate = DateTime.tryParse(value ?? '');
                            return state.validateDate(selectedDate);
                          },
                          labelText: "Purchased On",
                          hintText: "Enter date of purchase",
                          prefixicon: Icons.add_circle_outline,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DateFormField(
                          controller: expiryDateController,
                          onChanged: (String value) {
                            state.dateExpiresOn = DateTime.parse(value);
                          },
                          onPressed: () async {
                            final selectedDate =
                                await state.selectDate(context, 1);
                            if (selectedDate != null) {
                              // Update the value or perform any necessary actions
                              state.dateExpiresOn = selectedDate;
                              expiryDateController.text =
                                  DateFormat('dd/MM/yyyy').format(selectedDate);
                            }
                          },
                          //currentValue: state.datePurchased,
                          validator: (value) {
                            final selectedDate = DateTime.tryParse(value ?? '');
                            return state.validateDate(selectedDate);
                          },
                          labelText: "Expires on",
                          hintText: "Enter expiry date",
                          prefixicon: Icons.error_outline_rounded,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemStorageFormField(
                          onChanged: (s) => state.storedAt = s,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemDescFormField(
                          onChanged: (s) => state.description = s,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
