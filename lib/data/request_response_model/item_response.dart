class ItemResponse {
  int? itemID;
  String? itemName;
  String? itemType;
  int? quantity;
  DateTime? datePurchased;
  DateTime? dateExpiresOn;
  String? itemImageURL;
  String? storedAt;
  String? description;

  ItemResponse({
    this.itemID,
    this.itemName,
    this.itemType,
    this.quantity,
    this.datePurchased,
    this.dateExpiresOn,
    this.itemImageURL,
    this.storedAt,
    this.description,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) {
    return ItemResponse(
      itemID: json['itemID'],
      itemName: json['itemName'],
      itemType: json['itemType'],
      quantity: json['quantity'],
      datePurchased: DateTime.parse(json['datePurchased']),
      dateExpiresOn: DateTime.parse(json['dateExpiresOn']),
      itemImageURL: json['itemImageURL'],
      storedAt: json['storedAt'],
      description: json['description'],
    );
  }
}
