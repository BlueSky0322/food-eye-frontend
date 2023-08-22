import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/product_response.dart';
import 'package:food_eye_fyp/data/request_response_model/update_product_request.dart';
import 'package:food_eye_fyp/service/product_service.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProductState extends ChangeNotifier {
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

  final int productToEditID;
  ProductResponse productToEdit = ProductResponse();

  EditProductState(this.context, this.productToEditID) {
    getProductByID();
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
      if (productToEdit.productImageURL != null &&
          productToEdit.productImageURL != defaultImage) {
        return NetworkImage(productToEdit.productImageURL!);
      }
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

  Future<void> getProductByID() async {
    await _productService.getItemByID(productToEditID).then((product) {
      productToEdit = product;
      productNameController.text = productToEdit.productName!;
      productDescController.text = productToEdit.productDesc!;
      dateAddedController.text =
          DateFormat('yyyy-MM-dd').format(productToEdit.dateAdded!);
      priceController.text = productToEdit.price!.toString();
      shelfLifeController.text = productToEdit.shelfLife!.toString();
      status = productToEdit.status;

      notifyListeners();
    });
  }

  // Future<bool> addNewProduct() async {
  //   AddProductRequest newProduct = AddProductRequest(
  //     productName: productName,
  //     productDesc: productDesc,
  //     dateAdded: dateAdded,
  //     price: price,
  //     shelfLife: shelfLife,
  //     status: status,
  //     imagePath: imageFile != null ? imageFile!.path : defaultImage,
  //     userId: userProvider.userId,
  //   );

  //   return await _productService.addProduct(newProduct);
  // }

  Future<bool> updateProduct() async {
    try {
      UpdateProductRequest updatedProduct = UpdateProductRequest(
        productId: productToEditID,
        productName: productNameController.text,
        productDesc: productDescController.text,
        dateAdded: DateTime.parse(dateAddedController.text),
        price: double.parse(priceController.text),
        shelfLife: int.parse(shelfLifeController.text),
        status: status,
        imagePath: imageFile != null
            ? imageFile!.path
            : (imageFile == null && productToEdit.productImageURL != null)
                ? productToEdit.productImageURL
                : defaultImage,
      );
      notifyListeners();
      return await _productService.updateProduct(updatedProduct);
    } catch (error) {
      log('Error updating item: $error');
      return false;
    }
  }
}
