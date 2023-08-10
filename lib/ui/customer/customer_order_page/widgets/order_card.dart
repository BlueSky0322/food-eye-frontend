import 'package:flutter/material.dart';
import 'package:food_eye_fyp/data/request_response_model/customer_order_response.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:intl/intl.dart';

class CustomOrderCard extends StatelessWidget {
  final CustOrderResponse order;
  const CustomOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade100,
        ),
        // color:
        //     Color.fromARGB(255, 187, 222, 251)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
              width: 1.0,
              color: primaryBG,
            ))),
            child: Icon(
              Icons.my_library_books_outlined,
              color: Colors.teal.shade900,
            ),
          ),
          title: Text(
            order.productName,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: primaryBG,
                fontSize: 18,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            children: [
              Row(
                children: <Widget>[
                  const Text(
                    "Seller: ",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Color.fromARGB(255, 82, 105, 95),
                    ),
                  ),
                  Text(
                    order.sellerName,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "No. of products: ",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Color.fromARGB(255, 82, 105, 95),
                    ),
                  ),
                  Text(
                    "${order.quantity}",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Order Date: ",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Color.fromARGB(255, 82, 105, 95),
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(order.orderDate),
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Order Status: ",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Color.fromARGB(255, 82, 105, 95),
                    ),
                  ),
                  Text(
                    order.orderStatus,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
