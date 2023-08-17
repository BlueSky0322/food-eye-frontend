class AddOrderRequest {
  int? productId;
  String? userId;
  int? quantity;
  DateTime? orderDate;
  String orderStatus = "Pending";
  String orderDetails;

  AddOrderRequest({
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.orderDate,
    required this.orderDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'quantity': quantity,
      'orderDetails': orderDetails,
      'orderStatus': orderStatus,
      'orderDate': orderDate?.toIso8601String(),
    };
  }
}
