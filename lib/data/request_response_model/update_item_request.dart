class UpdateItemRequest {
  final int? itemId;
  final String? itemName;
  final String? itemType;
  final int quantity;
  final DateTime? datePurchased;
  final DateTime? dateExpiresOn;
  String? imagePath;
  final String? storedAt;
  final String? description;

  UpdateItemRequest({
    required this.itemId,
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
      'itemId': itemId,
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
}
