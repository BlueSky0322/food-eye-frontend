import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/item_response.dart';

import '../../../utils/constants.dart';

class ItemDetailState extends ChangeNotifier {
  //final BuildContext context;
  final ItemResponse item;
  ItemDetailState(this.item);

  ImageProvider<Object> get pickedImage {
    return Image.network(
      item.itemImageURL!,
      errorBuilder: (context, error, stackTrace) {
        log('Failed to load network image: $error');
        return const CircleAvatar(
          radius: 35.0,
          backgroundColor: pageBG,
          backgroundImage: NetworkImage(defaultImage),
        );
      },
    ).image;
  }
}
