import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    print("[DEBUG] list tile rebuilding");
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
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.white,
              backgroundImage: Image.asset(item.imagePath!).image,
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
                    // softWrap: false,
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      height: 1.2,
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
                              "Expired!",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 15,
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
                  const SizedBox(
                    height: 16,
                  ),
                  // Text("Expires in ${getRemainingDays(item.dateExpiresOn!)}"),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          )
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.more_vert_rounded,
          //       color: Theme.of(context).primaryColor,
          //     ))
        ],
      ),
    );
  }
}
