import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:intl/intl.dart';

import '../data/model/item.dart';

class CustomListTile extends StatelessWidget {
  final Item item;
  const CustomListTile({
    required this.item,
  });

  String getRemainingDays(DateTime expiryDate) {
    final currentDate = DateTime.now();
    final difference = expiryDate.difference(currentDate).inDays;
    return difference >= 0 ? '$difference days' : 'Expired';
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpiredText =
        getRemainingDays(item.dateExpiresOn!).contains("Expired");
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 10, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundColor: appbar,
            //display pickedImage if not null, else display asset image
            backgroundImage: Image.asset(item.imagePath!).image,
            // Display asset image if pickedImage is null
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName!,
                    overflow: TextOverflow.visible,
                    // softWrap: false,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      height: 0.95,
                      wordSpacing: 1.5,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: primaryBG,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isExpiredText
                          ? Text(
                              "Expired",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade800,
                              ),
                            )
                          : Text.rich(
                              TextSpan(
                                text: "Expires in  ",
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                                children: [
                                  TextSpan(
                                    text: getRemainingDays(item.dateExpiresOn!),
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
                      Text(
                        "Quantity: ${item.quantity}",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  // Text("Expires in ${getRemainingDays(item.dateExpiresOn!)}"),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }
}
