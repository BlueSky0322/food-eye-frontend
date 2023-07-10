import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

import '../../modules/image_recognition/image_bottom_sheet.dart';
// import 'bottom_sheet.dart';

class DisplayImage extends StatelessWidget {
  final ImageProvider pickedImage;

  const DisplayImage({
    super.key,
    required this.pickedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: appbar,
              width: 6.0,
            ),
          ),
          child: CircleAvatar(
            radius: 80.0,
            backgroundColor: Colors.transparent,
            //display pickedImage if not null, else display asset image
            backgroundImage: pickedImage,
            // Display asset image if pickedImage is null
          ),
        ),
      ]),
    );
  }
}
