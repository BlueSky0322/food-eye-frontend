import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/product_response.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:food_eye_fyp/utils/expiry_status.dart';
import 'package:intl/intl.dart';
import '../data/request_response_model/product_response.dart';

class CustomListTile extends StatelessWidget {
  final ProductResponse product;
  const CustomListTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    log("[DEBUG] list tile rebuilding");

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(22, 0, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryBG,
                width: 2.5,
              ),
            ),
            child: CircleAvatar(
              radius: 35.0,
              backgroundColor: pageBG,
              backgroundImage: (() {
                return Image.network(
                  product.productImageURL!,
                  errorBuilder: (context, error, stackTrace) {
                    log('Failed to load network image: $error');
                    return const CircleAvatar(
                      radius: 35.0,
                      backgroundColor: pageBG,
                      backgroundImage: NetworkImage(defaultImage),
                    );
                  },
                ).image;
              })(),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              decoration: const BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(
                  color: Colors.black,
                  width: 1,
                )),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      height: 1.2,
                      wordSpacing: 1.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryBG,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Date Added: ",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat.yMd()
                                      .format(product.dateAdded!),
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Shelf Life (days): ",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(
                                  text: "${product.shelfLife}",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Price (per unit): ",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "RM ${product.price!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (product.status == "Ending Soon")
                        Text(
                          "Ending \nSoon",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        )
                      else if (product.status == "Coming Soon")
                        Text(
                          "Coming \nSoon",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      else
                        Text(
                          "Preorder \nAvailable",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade500,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
