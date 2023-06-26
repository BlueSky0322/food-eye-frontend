import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemState extends ChangeNotifier {
  BuildContext context;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static const _100_YEARS = Duration(days: 365 * 100);
  XFile? imageFile;

  String? itemName;
  String? itemType;
  int quantity = 0;
  DateTime datePurchased = DateTime.now();
  DateTime dateExpiresOn = DateTime(2022, 12, 15);
  String? storedAt;
  String? description;

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

  Future selectPhoto(ImageSource source, ImagePicker picker) async {
    imageFile = await picker.pickImage(
      source: source,
    );
    notifyListeners();
  }
}
