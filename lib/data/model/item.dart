class Item {
  final String? itemName;
  final String? itemType;
  final int quantity;
  final DateTime? datePurchased;
  final DateTime? dateExpiresOn;
  String? imagePath;
  final String? storedAt;
  final String? description;

  Item({
    required this.itemName,
    required this.itemType,
    required this.quantity,
    required this.datePurchased,
    required this.dateExpiresOn,
    this.imagePath,
    required this.storedAt,
    required this.description,
  });
}

final itemList = <Item>[
  Item(
    itemName: 'Apple',
    itemType: 'Fruit',
    quantity: 5,
    datePurchased: DateTime(2022, 12, 10),
    dateExpiresOn: DateTime(2022, 12, 15),
    imagePath: 'assets/images/fruit.png',
    storedAt: "Pantry",
    description: 'Fresh and juicy apple',
  ),
  Item(
    itemName: 'Banana',
    itemType: 'Fruit',
    quantity: 3,
    datePurchased: DateTime(2022, 12, 8),
    dateExpiresOn: DateTime(2022, 12, 13),
    imagePath: 'assets/images/fruit.png',
    storedAt: "Pantry",
    description: 'Sweet and nutritious banana',
  ),
  Item(
    itemName: 'Orange',
    itemType: 'Fruit',
    quantity: 2,
    datePurchased: DateTime(2022, 12, 12),
    dateExpiresOn: DateTime(2022, 12, 17),
    imagePath: 'assets/images/fruit.png',
    storedAt: "Pantry",
    description: 'Tangy and refreshing orange',
  ),
];
