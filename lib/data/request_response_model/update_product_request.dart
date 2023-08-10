class UpdateProductRequest {
  int? productId;
  String? productName;
  String? productDesc;
  DateTime? dateAdded;
  double? price;
  int? shelfLife;
  String? status;
  String? imagePath;

  UpdateProductRequest({
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.dateAdded,
    required this.price,
    required this.shelfLife,
    required this.status,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'productID': productId,
      'productName': productName,
      'productDesc': productDesc,
      'dateAdded': dateAdded?.toIso8601String(),
      'price': price,
      'shelfLife': shelfLife,
      'status': status,
      'imagePath': imagePath,
    };
  }
}
