import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/custom_display_fields/display_field.dart';
import 'package:food_eye_fyp/components/custom_display_fields/display_image.dart';
import 'package:food_eye_fyp/ui/seller/products_detail_page/products_detail_page_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductDetailState>(context);
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
              "Product Details",
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
              _gap(),
              CustomDisplayField(
                labelText: "Name",
                valueText: state.product.productName!,
              ),
              _gap(),
              CustomDisplayField(
                labelText: "Description",
                valueText: state.product.productDesc!,
              ),
              _gap(),
              CustomDisplayField(
                labelText: "Date Added",
                valueText: DateFormat.yMMMd().format(state.product.dateAdded!),
              ),
              _gap(),
              CustomDisplayField(
                labelText: "Price",
                valueText: state.product.price.toString(),
              ),
              _gap(),
              CustomDisplayField(
                labelText: "Shelf Life",
                valueText: state.product.shelfLife.toString(),
              ),
              _gap(),
              CustomDisplayField(
                labelText: "Status",
                valueText: state.product.status!,
              ),
              _gap(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _gap() => const SizedBox(height: 16);
