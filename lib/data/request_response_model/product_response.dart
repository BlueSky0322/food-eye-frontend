class ProductResponse {
  int? productID;
  String? productName;
  String? productDesc;
  DateTime? dateAdded;
  double? price;
  int? shelfLife;
  String? status;
  String? productImageURL;

  ProductResponse({
    this.productID,
    this.productName,
    this.productDesc,
    this.dateAdded,
    this.price,
    this.shelfLife,
    this.status,
    this.productImageURL,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      productID: json['productID'],
      productName: json['productName'],
      productDesc: json['productDesc'],
      dateAdded: DateTime.parse(json['dateAdded']),
      price: json['price'],
      shelfLife: json['shelfLife'],
      status: json['status'],
      productImageURL: json['productImageURL'],
    );
  }
}
