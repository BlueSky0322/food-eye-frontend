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

// final itemList = <Item>[
  
// ];
