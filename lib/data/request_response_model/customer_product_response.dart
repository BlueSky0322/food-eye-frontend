class CustProductResponse {
  int? productId;
  String? productName;
  String? productDesc;
  double? price;
  int? shelfLife;
  String? status;
  String? productImageURL;
  String? sellerId;
  String? sellerName;

  CustProductResponse({
    this.productId,
    this.productName,
    this.productDesc,
    this.price,
    this.shelfLife,
    this.status,
    this.productImageURL,
    this.sellerId,
    this.sellerName,
  });

  factory CustProductResponse.fromJson(Map<String, dynamic> json) {
    return CustProductResponse(
      productId: json['productId'],
      productName: json['productName'],
      productDesc: json['productDesc'],
      price: json['price'],
      shelfLife: json['shelfLife'],
      status: json['status'],
      productImageURL: json['productImageURL'],
      sellerId: json['sellerId'],
      sellerName: json['sellerName'],
    );
  }
}
