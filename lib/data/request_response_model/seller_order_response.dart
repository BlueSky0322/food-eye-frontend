class SellerOrderResponse {
  final int orderId;
  final String productName;
  final String userName;
  final int quantity;
  final DateTime orderDate;
  final String orderStatus;
  final String orderDetails;

  SellerOrderResponse({
    required this.orderId,
    required this.productName,
    required this.userName,
    required this.quantity,
    required this.orderDate,
    required this.orderStatus,
    required this.orderDetails,
  });

  factory SellerOrderResponse.fromJson(Map<String, dynamic> json) {
    return SellerOrderResponse(
      orderId: json['orderId'],
      productName: json['productName'],
      userName: json['userName'],
      quantity: json['quantity'],
      orderDate: DateTime.parse(json['orderDate']),
      orderStatus: json['orderStatus'],
      orderDetails: json['orderDetails'],
    );
  }
}
