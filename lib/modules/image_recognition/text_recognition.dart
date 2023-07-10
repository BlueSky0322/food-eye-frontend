import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognitionHelper {
  static Future processImage(
    InputImage image,
    // TextEditingController controller,
    // Function(String) parseExpiryDate,
  ) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);
    return recognizedText;
    // controller.text = parseExpiryDate(recognizedText.text);
  }
}
