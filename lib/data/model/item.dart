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

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemType': itemType,
      'quantity': quantity,
      'datePurchased': datePurchased?.toIso8601String(),
      'dateExpiresOn': dateExpiresOn?.toIso8601String(),
      'imagePath': imagePath,
      'storedAt': storedAt,
      'description': description,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemName: json['itemName'],
      itemType: json['itemType'],
      quantity: json['quantity'],
      datePurchased: DateTime.parse(json['datePurchased']),
      dateExpiresOn: DateTime.parse(json['dateExpiresOn']),
      imagePath: json['imagePath'],
      storedAt: json['storedAt'],
      description: json['description'],
    );
  }
}
