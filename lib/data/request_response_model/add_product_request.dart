class AddProductRequest {
  String? productName;
  String? productDesc;
  DateTime? dateAdded;
  double? price;
  int? shelfLife;
  String? status;
  String? imagePath;
  String? userId;

  AddProductRequest({
    required this.productName,
    required this.productDesc,
    required this.dateAdded,
    required this.price,
    required this.shelfLife,
    required this.status,
    this.imagePath,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productDesc': productDesc,
      'dateAdded': dateAdded?.toIso8601String(),
      'price': price,
      'shelfLife': shelfLife,
      'status': status,
      'userId': userId,
    };
  }
}
