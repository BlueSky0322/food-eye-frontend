import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

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
            backgroundImage: pickedImage,
          ),
        ),
      ]),
    );
  }
}
