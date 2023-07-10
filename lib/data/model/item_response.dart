class ItemResponseObject {
  int? itemID;
  String? itemName;
  String? itemType;
  int? quantity;
  DateTime? datePurchased;
  DateTime? dateExpiresOn;
  String? imagePath;
  String? storedAt;
  String? description;

  ItemResponseObject({
    this.itemID,
    this.itemName,
    this.itemType,
    this.quantity,
    this.datePurchased,
    this.dateExpiresOn,
    this.imagePath,
    this.storedAt,
    this.description,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'itemName': itemName,
  //     'itemType': itemType,
  //     'quantity': quantity,
  //     'datePurchased': datePurchased?.toIso8601String(),
  //     'dateExpiresOn': dateExpiresOn?.toIso8601String(),
  //     'imagePath': imagePath,
  //     'storedAt': storedAt,
  //     'description': description,
  //   };
  // }

  factory ItemResponseObject.fromJson(Map<String, dynamic> json) {
    return ItemResponseObject(
      itemID: json['itemID'],
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
