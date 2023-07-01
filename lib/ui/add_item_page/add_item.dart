import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/error_alert_dialog.dart';
import 'package:food_eye_fyp/components/input_selection_dialog.dart';
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

import '../../components/success_alert_dialog.dart';
import '../../utils/constants.dart';
import 'components/item_name_field.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddItemState>(context);
    final ImagePicker picker = ImagePicker();
    TextEditingController purchasedDateController = TextEditingController();
    TextEditingController expiryDateController = TextEditingController();

    return Scaffold(
      backgroundColor: pageBG,
      appBar: AppBar(
        backgroundColor: appbar,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        elevation: 0,
        toolbarHeight: 70,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: appbarText,
              size: 40,
            ),
            Text(
              "Add new item",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: appbarText,
              ),
            ),
          ],
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
                            // pickedImage: ,
                            pickedImage: state.pickedImage,
                            onPressedGallery: () async {
                              state.selectPhoto(ImageSource.gallery, picker);
                            },
                            onPressedPhoto: () {
                              state.selectPhoto(ImageSource.camera, picker);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ItemNameFormField(
                            controller: state.itemNameController,
                            validator: (s) => state.validateIfEmpty(s),
                            onChanged: (s) => state.itemName = s,
                            onTap: () {
                              state.scanBarcodeNormal();
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ItemTypeFormField(
                            validator: (s) => state.validateIfEmpty(s),
                            onChanged: (s) => state.itemType = s,
                            currentValue: state.itemType,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ItemQuantityFormField(
                            validator: (s) => state.validateQuantity(s),
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
                            validator: (value) {
                              final selectedDate =
                                  DateTime.tryParse(value ?? '');
                              return state.validateDate(selectedDate);
                            },
                            onChanged: (String value) {
                              state.datePurchased = DateTime.parse(value);
                            },
                            controller: purchasedDateController,
                            onPressed: () async {
                              final selectedDate =
                                  await state.selectDate(context, 0);
                              if (selectedDate != null) {
                                // Update the value or perform any necessary actions
                                state.datePurchased = selectedDate;
                                purchasedDateController.text =
                                    DateFormat('yyyy-MM-dd')
                                        .format(selectedDate);
                              }
                            },
                            labelText: "Purchased On",
                            hintText: "Enter date of purchase",
                            prefixicon: Icons.add_circle_outline,
                            suffixIcon: Icons.calendar_today_rounded,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DateFormField(
                            controller: expiryDateController,
                            validator: (value) {
                              final selectedDate =
                                  DateTime.tryParse(value ?? '');
                              return state.validateDate(selectedDate);
                            },
                            onChanged: (String value) {
                              state.dateExpiresOn = DateTime.parse(value);
                            },
                            onPressed: () async {
                              final selectedOption = await showDialog<int>(
                                  context: context,
                                  builder: (context) {
                                    return const InputSelectionDailog();
                                  });

                              if (selectedOption == 0) {
                              } else if (selectedOption == 1) {
                                final selectedDate =
                                    await state.selectDate(context, 1);
                                if (selectedDate != null) {
                                  // Update the value or perform any necessary actions
                                  state.dateExpiresOn = selectedDate;
                                  expiryDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(selectedDate);
                                }
                              }
                            },
                            //currentValue: state.datePurchased,
                            labelText: "Expires on",
                            hintText: "Enter expiry date",
                            prefixicon: Icons.error_outline_rounded,
                            suffixIcon: Icons.pending_rounded,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ItemStorageFormField(
                            validator: (s) => state.validateIfEmpty(s),
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
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () async {
                          if (state.formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return const Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 16.0),
                                        Text(
                                          'Adding Item...',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              barrierDismissible: false,
                            );

                            bool success = await state.addNewItem();
                            Navigator.pop(context); // Close the progress dialog

                            Future.microtask(() {
                              if (success) {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return const CustomSuccessAlertDialog(
                                      imageAsset:
                                          'assets/images/newitem-logo.png',
                                      title: "Success!",
                                      subtitle: "Item Added",
                                      description:
                                          "The item has been successfully added to your inventory.",
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return const CustomErrorAlertDialog(
                                      imageAsset:
                                          'assets/images/error-logo.png',
                                      title: "Whoops!",
                                      subtitle: "Something went wrong...",
                                      description:
                                          "Sorry, but please try again later!",
                                    );
                                  },
                                );
                              }
                            });
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Add new item",
                              style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
