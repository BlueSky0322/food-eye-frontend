class Item {
  final String itemName;
  final String itemType;
  final int quantity;
  final DateTime datePurchased;
  final DateTime dateExpiresOn;
  final String imageUrl;
  final String storageLocation;
  final String description;

  Item({
    required this.itemName,
    required this.itemType,
    required this.quantity,
    required this.datePurchased,
    required this.dateExpiresOn,
    required this.imageUrl,
    required this.storageLocation,
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
    imageUrl: 'assets/images/fruit.png',
    storageLocation: "Pantry",
    description: 'Fresh and juicy apple',
  ),
  Item(
    itemName: 'Banana',
    itemType: 'Fruit',
    quantity: 3,
    datePurchased: DateTime(2022, 12, 8),
    dateExpiresOn: DateTime(2022, 12, 13),
    imageUrl: 'assets/images/fruit.png',
    storageLocation: "Pantry",
    description: 'Sweet and nutritious banana',
  ),
  Item(
    itemName: 'Orange',
    itemType: 'Fruit',
    quantity: 2,
    datePurchased: DateTime(2022, 12, 12),
    dateExpiresOn: DateTime(2022, 12, 17),
    imageUrl: 'assets/images/fruit.png',
    storageLocation: "Pantry",
    description: 'Tangy and refreshing orange',
  ),
  Item(
    itemName: 'Orange',
    itemType: 'Fruit',
    quantity: 2,
    datePurchased: DateTime(2022, 12, 12),
    dateExpiresOn: DateTime(2022, 12, 17),
    imageUrl: 'assets/images/fruit.png',
    storageLocation: "Pantry",
    description: 'Tangy and refreshing orange',
  ),
  Item(
    itemName: 'Orange',
    itemType: 'Fruit',
    quantity: 2,
    datePurchased: DateTime(2022, 12, 12),
    dateExpiresOn: DateTime(2022, 12, 17),
    imageUrl: 'assets/images/fruit.png',
    storageLocation: "Pantry",
    description: 'Tangy and refreshing orange',
  ),
  Item(
    itemName: 'Orange',
    itemType: 'Fruit',
    quantity: 2,
    datePurchased: DateTime(2022, 12, 12),
    dateExpiresOn: DateTime(2022, 12, 17),
    imageUrl: 'assets/images/fruit.png',
    storageLocation: "Pantry",
    description: 'Tangy and refreshing orange',
  ),
];
