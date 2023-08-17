import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_fields/product_fields/date_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/product_fields/price_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/product_fields/product_image.dart';
import 'package:food_eye_fyp/components/custom_input_fields/product_fields/product_status_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/product_fields/shelflife_field.dart';
import 'package:food_eye_fyp/components/custom_input_fields/product_fields/text_field.dart';
import 'package:food_eye_fyp/components/error_alert_dialog.dart';
import 'package:food_eye_fyp/components/success_alert_dialog.dart';
import 'package:food_eye_fyp/ui/seller/add_product_page/add_product_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddProductState>(context);
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
                "Add products",
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
                            ProductImage(
                              // pickedImage: ,
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
                            CustomTextFormField(
                              controller: state.productNameController,
                              validator: (s) => state.validateIfEmpty(s),
                              onChanged: (s) => state.productName = s,
                              labelText: "Product Name",
                              hintText: "Enter product name",
                              textcolour: Colors.teal.shade800,
                              prefixicon: Icons.font_download_rounded,
                              suffixIcon: null,
                            ),
                            _gap(),
                            CustomTextFormField(
                              controller: state.productDescController,
                              validator: (s) => state.validateIfEmpty(s),
                              onChanged: (s) => state.productDesc = s,
                              labelText: "Product Description",
                              hintText: "Enter a short description",
                              textcolour: Colors.teal.shade800,
                              prefixicon: Icons.description_rounded,
                              suffixIcon: null,
                            ),
                            _gap(),
                            DateFormField(
                              validator: (value) {
                                final selectedDate =
                                    DateTime.tryParse(value ?? '');
                                return state.validateDate(selectedDate);
                              },
                              onChanged: (String value) {
                                state.dateAdded = DateTime.parse(value);
                              },
                              controller: state.dateAddedController,
                              onPressed: () async {
                                await state.selectAndAssignDate();
                              },
                              labelText: "Date added",
                              hintText: "Enter when the product was added",
                              prefixicon: Icons.timer_outlined,
                              suffixIcon: Icons.calendar_today_rounded,
                              initialValue: null,
                            ),
                            _gap(),
                            PriceFormField(
                              validator: (s) => state.validatePrice(s),
                              onChanged: (value) {
                                double parsedPrice = double.parse(value);
                                state.price = parsedPrice;
                              },
                              controller: state.priceController,
                              labelText: "Price per unit (RM)",
                              hintText: "Enter price (e.g., 6.90)",
                              textcolour: Colors.teal.shade800,
                              prefixicon: Icons.attach_money_rounded,
                              suffixIcon: null,
                            ),
                            _gap(),
                            ShelfLifeFormField(
                              validator: (s) => state.validateQuantity(s),
                              onChanged: (value) {
                                int parsedVal = int.parse(value);
                                state.shelfLife = parsedVal;
                              },
                              controller: state.shelfLifeController,
                              labelText: "Shelf Life (Days)",
                              hintText: "Enter shelf life of product",
                              textcolour: Colors.teal.shade800,
                              prefixicon: Icons.shelves,
                              suffixIcon: null,
                            ),
                            _gap(),
                            ProductStatusFormField(
                              validator: (s) => state.validateIfEmpty(s),
                              onChanged: (s) => state.status = s,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        width: 225,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
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
                                            'Adding Product...',
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

                              bool success = await state.addNewProduct();
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
                                        subtitle: "Product Added",
                                        description:
                                            "The product has been successfully added to your inventory.",
                                      );
                                    },
                                  ).then(
                                    (value) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/products',
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
                                "Add new product",
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

Widget _gap() => const SizedBox(height: 16);
