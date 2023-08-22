import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/add_item_request.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/barcode_lookup_service.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../modules/barcode_scanner/barcode_scanner.dart';
import '../../../modules/image_recognition/expiry_date_parser.dart';
import '../../../modules/image_recognition/image_input.dart';
import '../../../modules/image_recognition/text_recognition.dart';
import '../../../service/item_service.dart';
import '../../../utils/constants.dart';

class AddItemState extends ChangeNotifier {
  BuildContext context;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: "1");
  TextEditingController purchasedDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<State> dialogKey = GlobalKey<State>();
  final _barcodeLookupService = BarcodeLookupService();
  // final client = Client();
  final _itemService = ItemService();
  final ImagePicker picker = ImagePicker();
  // static const _100_YEARS = Duration(days: 365 * 100);

  XFile? _imageFile;
  String? itemName;
  String? itemType;
  int quantity = 1;
  DateTime? datePurchased;
  DateTime? dateExpiresOn;
  String? storedAt;
  String? description;
  XFile? get imageFile => _imageFile;

  late UserProvider userProvider;
  AddItemState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<bool> addNewItem() async {
    // Validate form fields
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      AddItemRequest newItem = AddItemRequest(
        itemName: itemName,
        itemType: itemType,
        quantity: quantity,
        datePurchased: datePurchased,
        dateExpiresOn: dateExpiresOn,
        storedAt: storedAt,
        description: description,
        // Set the imageFile path if available
        imagePath: imageFile != null ? imageFile!.path : defaultImage,
        userId: userProvider.userId,
      );

      return await _itemService.addItem(newItem);
    } catch (error) {
      log('Error creating item: $error');
      return false;
    }
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
    } else {
      return const NetworkImage(
        defaultImage,
      );
    }
  }

  void selectPhoto(ImageSource source) async {
    final pickedImage = await picker.pickImage(
      source: source,
    );
    _imageFile = pickedImage;
    notifyListeners();
  }

  void processBarcode() async {
    final scannedName = await BarcodeScannerHelper.scanBarcodeNormal();
    log(scannedName);
    if (scannedName != "Error") {
      itemName =
          await _barcodeLookupService.lookupProductName(code: scannedName);
      log(itemName!);
      if (itemName != "Product not found" && itemName != "-1") {
        itemNameController.text = itemName!;
        notifyListeners();
      }
    } else {
      itemNameController.clear();
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
