import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_fields/order_fields/text_field.dart';
import 'package:food_eye_fyp/components/error_alert_dialog.dart';
import 'package:food_eye_fyp/components/success_alert_dialog.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_product_response.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/customer_home_page_state.dart';
import 'package:food_eye_fyp/utils/color_helper.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:input_quantity/input_quantity.dart';

class PreorderPopup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  final CustomerHomePageState state;
  final CustProductResponse product;
  String orderDetails = "";

  PreorderPopup({
    super.key,
    required this.state,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Preorder",
        style: TextStyle(
          fontFamily: 'Outfit',
          color: primaryBG,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
              child: Image.network(
                "${product.productImageURL}",
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: GetColorHelper.getColorByStatus(product.status!),
                    ), // Set the background color here
                    width: 100,
                    height: 20,
                    child: Center(
                      child: Text(
                        "${product.status}",
                        style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  product.productName!,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
                Text(
                  "by ${product.sellerName}",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "RM ${product.price!.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    validator: null,
                    onChanged: (s) => orderDetails = s,
                    controller: _textFieldController,
                    labelText: "Order Details",
                    hintText: "Tell the seller something",
                    prefixicon: Icons.description_rounded,
                    suffixIcon: null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputQty(
                    maxVal: 50,
                    initVal: 1,
                    minVal: 0,
                    steps: 1,
                    isIntrinsicWidth: false,
                    borderShape: BorderShapeBtn.none,
                    plusBtn: const Icon(Icons.add_box),
                    minusBtn: const Icon(Icons.indeterminate_check_box),
                    btnColor1: Colors.teal,
                    btnColor2: Colors.red,
                    onQtyChanged: (val) {
                      state.quantity = val as int;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 2,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
              ),
              // onPressed: confirmButtonPressed,
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'Outfit',
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
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
                                'Processing Order...',
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

                  if (orderDetails == "") {
                    orderDetails = "No remarks";
                  }
                  state.productId = product.productId;
                  state.orderDetails = orderDetails;
                  log("${state.quantity} ${state.orderDetails}");

                  bool success = await state.addOrder();
                  Future.microtask(
                    () => Navigator.pop(context),
                  );
                  Future.microtask(() {
                    if (success) {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return const CustomSuccessAlertDialog(
                            imageAsset: 'assets/images/newitem-logo.png',
                            title: "Success!",
                            subtitle: "Order Processed",
                            description: "You order has been added.",
                          );
                        },
                      ).then(
                        (value) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/custorders',
                            (route) => false,
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return const CustomErrorAlertDialog(
                            imageAsset: 'assets/images/error-logo.png',
                            title: "Whoops!",
                            subtitle: "Something went wrong...",
                            description: "Sorry, but please try again later!",
                          );
                        },
                      );
                    }
                  });
                }
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: appbarText,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: primaryBG,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
