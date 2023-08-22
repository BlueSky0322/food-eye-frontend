import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_product_response.dart';
import 'package:food_eye_fyp/utils/color_helper.dart';

class CustomGridTile extends StatelessWidget {
  final CustProductResponse product;
  final VoidCallback? preorderButtonPressed;
  const CustomGridTile({
    super.key,
    required this.product,
    required this.preorderButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        color: Colors.teal.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Image.network(
              "${product.productImageURL}",
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: GetColorHelper.getColorByStatus(product.status!),
                    ), // Set the background color here
                    width: 100,
                    height: 20,
                    child: Center(
                      child: Text(
                        "${product.status}",
                        style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${product.productName}",
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "RM ${product.price!.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "by ${product.sellerName}",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: preorderButtonPressed,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        Text(
                          "Preorder",
                          style: TextStyle(
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
