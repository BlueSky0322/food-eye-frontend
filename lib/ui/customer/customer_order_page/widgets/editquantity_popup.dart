import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_fields/order_fields/text_field.dart';
import 'package:food_eye_fyp/components/error_alert_dialog.dart';
import 'package:food_eye_fyp/components/success_alert_dialog.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_order_response.dart';
import 'package:food_eye_fyp/ui/customer/customer_order_page/customer_order_page_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:input_quantity/input_quantity.dart';

// ignore: must_be_immutable
class EditQuantityPopup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final CustOrderPageState state;
  final CustOrderResponse order;
  final _textFieldController = TextEditingController();

  EditQuantityPopup({
    super.key,
    required this.state,
    required this.order,
  }) {
    state.orderId = order.orderId;
  }

  @override
  Widget build(BuildContext context) {
    _textFieldController.text = order.orderDetails;
    return AlertDialog(
      title: const Text(
        "Edit Order",
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
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    validator: null,
                    onChanged: (s) => state.orderDetails = s,
                    controller: _textFieldController,
                    labelText: "Order Details",
                    hintText: "Tell the seller something",
                    prefixicon: Icons.description_rounded,
                    suffixIcon: Icons.cancel,
                    onPressed: () {
                      _textFieldController.text = "";
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputQty(
                    maxVal: 50,
                    initVal: order.quantity,
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
                                'Processing Update...',
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

                  bool success = await state.custUpdateOrder();
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
