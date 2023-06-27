import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_eye_fyp/service/barcode_lookup.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/item.dart';

class AddItemState extends ChangeNotifier {
  BuildContext context;
  TextEditingController itemNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<State> dialogKey = GlobalKey<State>();
  final _barcodeLookupService = BarcodeLookupService();
  static const _100_YEARS = Duration(days: 365 * 100);

  XFile? _imageFile;
  String? _scannedName;
  String? itemName;
  String? itemType;
  int quantity = 1;
  DateTime? datePurchased;
  DateTime? dateExpiresOn;
  String? storedAt;
  String? description;
  XFile? get imageFile => _imageFile;

  //List<Item> _itemList = [];
  AddItemState(this.context);

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid integer.';
    }

    return null;
  }

  String? validateDate(DateTime? value) {
    if (value == null) {
      return 'Field cannot be blank';
    }
    return null;
  }

  String? validateIfEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }
    return null;
  }

  Future<DateTime?> selectDate(BuildContext context, int selectRange) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: selectRange == 0 ? DateTime(1900) : DateTime.now(),
      lastDate:
          selectRange == 0 ? DateTime.now() : DateTime.now().add(_100_YEARS),
    );
    return selectedDate;
  }

  ImageProvider<Object> get pickedImage {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile!.path),
        fit: BoxFit.cover,
      ).image;
    } else {
      return const AssetImage(
        'assets/images/image-placeholder.png',
      );
    }
  }

  void selectPhoto(ImageSource source, ImagePicker picker) async {
    final pickedImage = await picker.pickImage(
      source: source,
    );
    _imageFile = pickedImage;
    notifyListeners();
  }

  Future<void> scanBarcodeNormal() async {
    try {
      _scannedName = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      ).then((value) {
        if (value == -1) {
          return null;
        }
      });

      await _barcodeLookupService
          .lookupProductName(code: _scannedName!)
          .then((productName) {
        itemName = productName;
        itemNameController.text = itemName!;
        print(itemName);
        notifyListeners();
      });
    } on PlatformException {
      _scannedName = "Error";
    }
  }

  Future<bool> addNewItem() async {
    // Validate form fields
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      // Create your objects here
      // For example, you can create a new Item object with the provided data
      Item newItem = Item(
        itemName: itemName,
        itemType: itemType,
        quantity: quantity,
        datePurchased: datePurchased,
        dateExpiresOn: dateExpiresOn,
        storedAt: storedAt,
        description: description,
        // Set the imageFile path if available
        imagePath: imageFile != null ? imageFile!.path : null,
      );

      // Print the captured data to the console
      print('New Item Data:');
      print('Item Name: ${newItem.itemName}');
      print('Item Type: ${newItem.itemType}');
      print('Quantity: ${newItem.quantity}');
      print('Date Purchased: ${newItem.datePurchased}');
      print('Expires On: ${newItem.dateExpiresOn}');
      print('Stored At: ${newItem.storedAt}');
      print('Description: ${newItem.description}');
      print('Image Path: ${newItem.imagePath}');

      // Perform any necessary operations, such as saving to a database or API call

      // Return true to indicate that the item was successfully created
      return true;
    } catch (error) {
      // Handle any errors that occur during the creation process
      print('Error creating item: $error');
      return false;
    }
  }
}
