import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../modules/image_recognition/image_cropper.dart';
import '../../utils/image_picker.dart';

class ImageInput {
  static void imageInputSelection(
    BuildContext context,
    ImageSource source,
    Function(String) processImage,
  ) {
    pickImage(source: source).then((value) {
      if (value.isNotEmpty) {
        imageCropperView(value, context).then((value) {
          if (value != '') {
            processImage(value);
          }
        });
      }
    });
  }
}
