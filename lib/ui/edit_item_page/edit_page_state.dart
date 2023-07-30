import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_eye_fyp/data/model/item_response.dart';
import 'package:food_eye_fyp/service/barcode_lookup_service.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../data/model/item.dart';
import '../../modules/image_recognition/expiry_date_parser.dart';
import '../../modules/image_recognition/image_input.dart';
import '../../modules/image_recognition/text_recognition.dart';
import '../../service/item_service.dart';
import '../../utils/constants.dart';

class EditItemState extends ChangeNotifier {
  BuildContext context;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController purchasedDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<State> dialogKey = GlobalKey<State>();

  final _barcodeLookupService = BarcodeLookupService();
  final int itemToEditID;
  ItemResponseObject itemToEdit = ItemResponseObject();
  final client = Client();
  final _itemService = ItemService();

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

  EditItemState(
    this.context,
    this.itemToEditID,
  ) {
    getItemByID();
  }

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
          selectRange == 0 ? DateTime.now() : DateTime.now().add(hundredYears),
    );
    return selectedDate;
  }

  ImageProvider<Object> get pickedImage {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile!.path),
        fit: BoxFit.cover,
      ).image;
    } else if (itemToEdit.imagePath != null &&
        itemToEdit.imagePath != defaultImage) {
      return FileImage(File(itemToEdit.imagePath!));
    } else {
      return const AssetImage(
        defaultImage,
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
        // ignore: unrelated_type_equality_checks
        if (value == -1) {
          return null;
        }
        return null;
      });

      await _barcodeLookupService
          .lookupProductName(code: _scannedName!)
          .then((productName) {
        itemName = productName;
        itemNameController.text = itemName!;
        // print(itemName);
        notifyListeners();
      });
    } on PlatformException {
      _scannedName = "Error";
    }
  }

  Future<void> getItemByID() async {
    await _itemService.getItemByID(itemToEditID).then((item) {
      itemToEdit = item;
      itemNameController.text = itemToEdit.itemName!;
      itemType = itemToEdit.itemType;
      quantityController.text = itemToEdit.quantity!.toString();
      purchasedDateController.text =
          DateFormat('yyyy-MM-dd').format(itemToEdit.datePurchased!);
      expiryDateController.text =
          DateFormat('yyyy-MM-dd').format(itemToEdit.dateExpiresOn!);
      storedAt = itemToEdit.storedAt;
      if (itemToEdit.description != null) {
        descriptionController.text = itemToEdit.description!;
      } else {
        descriptionController.clear();
      }

      notifyListeners();
    });
  }

  Future<bool> updateItem() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    try {
      Item updatedItem = Item(
        itemName: itemNameController.text,
        itemType: itemType,
        quantity: int.parse(quantityController.text),
        datePurchased: DateTime.parse(purchasedDateController.text),
        dateExpiresOn: DateTime.parse(expiryDateController.text),
        storedAt: storedAt,
        description: descriptionController.text,
        imagePath: imageFile != null
            ? imageFile!.path
            : (imageFile == null && itemToEdit.imagePath != null)
                ? itemToEdit.imagePath
                : defaultImage,
      );
      notifyListeners();
      return await _itemService.updateItem(itemToEditID, updatedItem);
    } catch (error) {
      log('Error creating item: $error');
      return false;
    }
  }

  void imageInputSelection(ImageSource source) {
    ImageInput.imageInputSelection(context, source, processImage);
  }

  void processImage(String imagePath) async {
    final InputImage inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await TextRecognitionHelper.processImage(inputImage);

    dateExpiresOn = DateTime.parse(parseExpiryDate(recognizedText.text));
    log(dateExpiresOn.toString());
    expiryDateController.text = DateFormat('yyyy-MM-dd').format(dateExpiresOn!);
  }

  Future<void> assignExpiryDate() async {
    final selectedDate = await selectDate(context, 1);
    if (selectedDate != null) {
      // Update the value or perform any necessary actions
      dateExpiresOn = selectedDate;
      log(dateExpiresOn.toString());
      expiryDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  Future<void> assignPurchaseDate() async {
    final selectedDate = await selectDate(context, 0);
    if (selectedDate != null) {
      // Update the value or perform any necessary actions
      datePurchased = selectedDate;
      log(datePurchased.toString());
      purchasedDateController.text =
          DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }
}
