import 'dart:developer';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

Future<String> pickImage({ImageSource? source}) async {
  final picker = ImagePicker();

  String path = '';

  try {
    final getImage = await picker.pickImage(source: source!);

    if (getImage != null) {
      path = getImage.path;
    } else {
      path = '';
    }
  } catch (e) {
    log(e.toString());
  }

  return path;
}

Future<XFile?> compress(File imagefile) async {
  return await FlutterImageCompress.compressAndGetFile(
    imagefile.absolute.path,
    '${imagefile.absolute.path}-compressed.jpg',
    quality: 33,
  );
}
