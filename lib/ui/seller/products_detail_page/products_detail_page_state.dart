import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/product_response.dart';
import 'package:food_eye_fyp/utils/constants.dart';

class ProductDetailState extends ChangeNotifier {
  //final BuildContext context;
  final ProductResponse product;
  ProductDetailState(this.product);

  ImageProvider<Object> get pickedImage {
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
  }
}
