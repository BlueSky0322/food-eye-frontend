import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/add_product_request.dart';
import 'package:food_eye_fyp/provider/user_provider.dart';
import 'package:food_eye_fyp/service/product_service.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProductState extends ChangeNotifier {
  BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<State> dialogKey = GlobalKey<State>();
  final ImagePicker picker = ImagePicker();
  final _productService = ProductService();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController dateAddedController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shelfLifeController = TextEditingController();

  String? productName;
  String? productDesc;
  DateTime? dateAdded;
  double? price;
  int? shelfLife;
  String? status;
  String? userId;
  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  late UserProvider userProvider;
  AddProductState(this.context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid integer.';
    }
    if (intValue <= 0) {
      return 'Shelf life must be greater than zero.';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be blank';
    }

    final doubleVal = double.tryParse(value);
    if (doubleVal == null) {
      return 'Please enter a valid number.';
    }

    if (doubleVal <= 0) {
      return 'Price must be greater than zero.';
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

  Future<void> selectAndAssignDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      dateAdded = selectedDate;
      dateAddedController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  Future<bool> addNewProduct() async {
    AddProductRequest newProduct = AddProductRequest(
      productName: productName,
      productDesc: productDesc,
      dateAdded: dateAdded,
      price: price,
      shelfLife: shelfLife,
      status: status,
      imagePath: imageFile != null ? imageFile!.path : defaultImage,
      userId: userProvider.userId,
    );

    return await _productService.addProduct(newProduct);
  }
}
