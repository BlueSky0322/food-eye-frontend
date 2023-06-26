import 'package:flutter/material.dart';

import '../data/model/item.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onDelete;
  const ItemList(this.items, this.onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Name: ${items[index].itemName}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Quantity: ${items[index].quantity}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Date Purchased: ${items[index].datePurchased}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Expires on: ${items[index].dateExpiresOn}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onDelete(items[index]),
              )
            ],
          ),
        ),
      ),
      itemCount: items.length,
    );
  }
}
