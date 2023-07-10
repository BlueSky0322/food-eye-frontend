import 'package:flutter/material.dart';

void imagePickerModal(
  BuildContext context, {
  VoidCallback? onPressedPhoto,
  VoidCallback? onPressedGallery,
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
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
      });
}
