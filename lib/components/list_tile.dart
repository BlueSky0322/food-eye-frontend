import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:intl/intl.dart';
import '../data/model/item_response.dart';

class CustomListTile extends StatelessWidget {
  final ItemResponseObject item;
  const CustomListTile({
    super.key,
    required this.item,
  });
  String getExpiryStatus(DateTime expiryDate) {
    final currentDate = DateTime.now();
    final difference = expiryDate.difference(currentDate).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Expires TODAY';
    } else if (difference <= 14) {
      return '$difference day(s)';
    } else {
      return DateFormat.yMd().format(expiryDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpiredText =
        getExpiryStatus(item.dateExpiresOn!).contains("Expired");
    final bool isExpiresTodayText =
        getExpiryStatus(item.dateExpiresOn!).contains("Expires TODAY");
    final bool isExpiresInTwoWeeksText =
        getExpiryStatus(item.dateExpiresOn!).contains(RegExp(r'day\(s\)'));

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
                if (item.imagePath == null || item.imagePath == defaultImage) {
                  return Image.asset(defaultImage).image;
                } else {
                  try {
                    return FileImage(File(item.imagePath!));
                  } catch (e) {
                    return Image.asset(defaultImage).image;
                  }
                }
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
                    item.itemName!,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isExpiredText)
                        Text(
                          "Expired!",
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800,
                          ),
                        )
                      else if (isExpiresTodayText)
                        Text.rich(
                          TextSpan(
                            text: "Expires \n",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            children: [
                              TextSpan(
                                text: "TODAY",
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade800,
                                ),
                              )
                            ],
                          ),
                        )
                      else if (isExpiresInTwoWeeksText)
                        Text.rich(
                          TextSpan(
                            text: "Expires in \n ",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            children: [
                              TextSpan(
                                text: getExpiryStatus(item.dateExpiresOn!),
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                        )
                      else
                        Text.rich(
                          TextSpan(
                            text: "Expires by \n",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            children: [
                              TextSpan(
                                text: DateFormat.yMMM()
                                    .format(item.dateExpiresOn!),
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Quantity: ${item.quantity}",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          Text(
                            "Stored in ${item.storedAt}",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ],
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
