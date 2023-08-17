import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/error_alert_dialog.dart';
import 'package:food_eye_fyp/components/input_selection_dialog.dart';
import 'package:food_eye_fyp/ui/seller/add_item_page/add_item_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_input_fields/date_field.dart';
import '../../../components/custom_input_fields/item_desc_field.dart';
import '../../../components/custom_input_fields/item_image.dart';
import '../../../components/custom_input_fields/item_name_field.dart';
import '../../../components/custom_input_fields/item_quantity_field.dart';
import '../../../components/custom_input_fields/item_storage_field.dart';
import '../../../components/custom_input_fields/item_type_field.dart';
import '../../../components/success_alert_dialog.dart';
import '../../../modules/image_recognition/image_bottom_sheet.dart';
import '../../../utils/constants.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddItemState>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: pageBG,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: appbarText,
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add item",
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
                              pickedImage: state.pickedImage,
                              onPressedGallery: () async {
                                state.selectPhoto(ImageSource.gallery);
                              },
                              onPressedPhoto: () {
                                state.selectPhoto(ImageSource.camera);
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ItemNameFormField(
                              controller: state.itemNameController,
                              validator: (s) => state.validateIfEmpty(s),
                              onChanged: (s) => state.itemName = s,
                              onPressed: () {
                                state.processBarcode();
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ItemTypeFormField(
                              validator: (s) => state.validateIfEmpty(s),
                              onChanged: (s) => state.itemType = s,
                              initialValue: state.itemType,
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
                              controller: state.quantityController,
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
                              controller: state.purchasedDateController,
                              onPressed: () async {
                                await state.assignPurchaseDate();
                              },
                              labelText: "Purchased On",
                              hintText: "Enter date of purchase",
                              prefixicon: Icons.add_circle_outline,
                              suffixIcon: Icons.calendar_today_rounded,
                              initialValue: null,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DateFormField(
                              controller: state.expiryDateController,
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
                                  Future.microtask(() {
                                    imagePickerModal(context,
                                        onPressedPhoto: () {
                                      log("camera");
                                      state.imageInputSelection(
                                          ImageSource.camera);
                                    }, onPressedGallery: () {
                                      log("gallery");
                                      state.imageInputSelection(
                                          ImageSource.gallery);
                                    });
                                  });
                                } else if (selectedOption == 1) {
                                  await state.assignExpiryDate();
                                }
                              },
                              initialValue: null,
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
                              controller: state.descriptionController,
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
                              // ignore: use_build_context_synchronously
                              Navigator.pop(
                                  context); // Close the progress dialog

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
                                  ).then(
                                    (value) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/home',
                                        (route) => false,
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
      ),
    );
  }
}
