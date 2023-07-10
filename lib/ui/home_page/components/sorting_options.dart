import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

Future<String?> loadSortingOptions(
    BuildContext context, List<String> sortingOptions) async {
  final selectedOption = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(
      (MediaQuery.of(context).size.width) / 1.6,
      (MediaQuery.of(context).size.height) / 2.5,
      (MediaQuery.of(context).size.width),
      (MediaQuery.of(context).size.height) / 2,
    ),
    items: sortingOptions.map((option) {
      return PopupMenuItem<String>(
        value: option,
        child: Text(
          option,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 14,
            color: primaryBG,
          ),
        ),
      );
    }).toList(),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    color: Colors.white,
  );

  return selectedOption;
}
