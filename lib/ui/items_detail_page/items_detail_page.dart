import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_display_fields/display_field.dart';
import 'package:food_eye_fyp/components/custom_display_fields/display_image.dart';
import 'package:food_eye_fyp/ui/items_detail_page/items_detail_page_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ItemDetailState>(context);
    return Scaffold(
      backgroundColor: pageBG,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: appbarText,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        backgroundColor: appbar,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        elevation: 0,
        toolbarHeight: 70,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Item Details",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: appbarText,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Outer box outline
              DisplayImage(pickedImage: state.pickedImage),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Item Name",
                valueText: state.item.itemName!,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Item Type",
                valueText: state.item.itemType!,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Quantity",
                valueText: state.item.quantity.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Purchased",
                valueText: DateFormat.yMMMd().format(state.item.datePurchased!),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Expires on",
                valueText: DateFormat.yMMMd().format(state.item.dateExpiresOn!),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Stored at",
                valueText: state.item.storedAt!,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomDisplayField(
                labelText: "Description",
                valueText: state.item.description!,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
