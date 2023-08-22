class CustOrderResponse {
  final int orderId;
  final String productName;
  final String sellerName;
  final int quantity;
  final DateTime orderDate;
  final String orderStatus;
  final String orderDetails;

  CustOrderResponse({
    required this.orderId,
    required this.productName,
    required this.sellerName,
    required this.quantity,
    required this.orderDate,
    required this.orderStatus,
    required this.orderDetails,
  });

  factory CustOrderResponse.fromJson(Map<String, dynamic> json) {
    return CustOrderResponse(
      orderId: json['orderId'],
      productName: json['productName'],
      sellerName: json['sellerName'],
      quantity: json['quantity'],
      orderDate: DateTime.parse(json['orderDate']),
      orderStatus: json['orderStatus'],
      orderDetails: json['orderDetails'],
    );
  }
}
