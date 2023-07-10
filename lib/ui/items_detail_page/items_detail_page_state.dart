import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/model/item_response.dart';

import '../../utils/constants.dart';

class ItemDetailState extends ChangeNotifier {
  //final BuildContext context;
  final ItemResponseObject item;
  ItemDetailState(this.item);

  ImageProvider<Object> get pickedImage {
    if (item.imagePath != null && item.imagePath != defaultImage) {
      return FileImage(File(item.imagePath!));
    } else {
      return const AssetImage(
        defaultImage,
      );
    }
  }
}
