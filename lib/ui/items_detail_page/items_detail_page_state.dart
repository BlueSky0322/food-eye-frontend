import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/model/item_response.dart';

import '../../utils/constants.dart';

class ItemDetailState extends ChangeNotifier {
  //final BuildContext context;
  final ItemResponseObject item;
  ItemDetailState(this.item);

  ImageProvider<Object> get pickedImage {
    try {
      if (item.imagePath == null || item.imagePath == defaultImage) {
        return const AssetImage(
          defaultImage,
        );
      } else if (item.imagePath!.startsWith("assets/images/")) {
        return AssetImage(item.imagePath!);
      } else {
        return FileImage(File(item.imagePath!));
      }
    } on Exception {
      return const AssetImage(
        defaultImage,
      );
    }
  }
}
