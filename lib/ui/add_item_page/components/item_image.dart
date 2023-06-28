import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemImage extends StatelessWidget {
  ImageProvider pickedImage;
  final VoidCallback? onPressedPhoto;
  final VoidCallback? onPressedGallery;

  ItemImage({
    super.key,
    required this.pickedImage,
    required this.onPressedPhoto,
    required this.onPressedGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.transparent,
          //display pickedImage if not null, else display asset image
          backgroundImage: pickedImage,
          // Display asset image if pickedImage is null
        ),
        Positioned(
          bottom: 20.0,
          right: 0.0,
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet(context)),
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

  Container bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Choose a photo",
            style: TextStyle(
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: onPressedPhoto,
                label: const Text(
                  "Camera",
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: onPressedGallery,
                label: const Text(
                  "Gallery",
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
