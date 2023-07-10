import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerHelper {
  static Future<String> scanBarcodeNormal() async {
    String scannedName = '';
    try {
      scannedName = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scannedName = "Error";
    }
    return scannedName;
  }
}
