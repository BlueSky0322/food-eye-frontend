import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_input_fields/order_fields/product_status_field.dart';
import 'package:food_eye_fyp/components/error_alert_dialog.dart';
import 'package:food_eye_fyp/components/success_alert_dialog.dart';
import 'package:food_eye_fyp/data/request_response_model/seller_order_response.dart';
import 'package:food_eye_fyp/ui/seller/orders_page/orders_page_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';

// ignore: must_be_immutable
class EditStatusPopup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final OrdersPageState state;
  final SellerOrderResponse order;
  String orderDetails = "";

  EditStatusPopup({
    super.key,
    required this.state,
    required this.order,
  }) {
    state.orderId = order.orderId;
  }

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
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderStatusFormField(
                    initialValue: order.orderStatus,
                    validator: (s) => state.validateIfEmpty(s),
                    onChanged: (s) => state.orderStatus = s,
                  )
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
                                'Updating Order...',
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
                  log("${state.orderStatus} ${state.orderId}");

                  bool success = await state.sellerUpdateOrder();
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
                            subtitle: "Order Updated",
                            description: "The order has been updated.",
                          );
                        },
                      ).then(
                        (value) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/orders',
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
