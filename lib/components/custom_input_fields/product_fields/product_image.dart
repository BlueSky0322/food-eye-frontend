import 'package:flutter/material.dart';
import 'package:food_eye_fyp/modules/image_recognition/image_bottom_sheet.dart';
import 'package:food_eye_fyp/utils/constants.dart';

class ProductImage extends StatelessWidget {
  final ImageProvider pickedImage;
  final VoidCallback? onPressedPhoto;
  final VoidCallback? onPressedGallery;

  const ProductImage({
    super.key,
    required this.pickedImage,
    required this.onPressedPhoto,
    required this.onPressedGallery,
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
        Positioned(
          bottom: 20.0,
          right: 0.0,
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {
                imagePickerModal(
                  context,
                  onPressedPhoto: onPressedPhoto,
                  onPressedGallery: onPressedGallery,
                );
              },
              child: const Center(
                child: Icon(
                  Icons.add_a_photo_rounded,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
