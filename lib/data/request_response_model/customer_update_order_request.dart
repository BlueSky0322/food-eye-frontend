class CustomerUpdateOrderRequest {
  int? orderId;
  int? quantity;
  String? orderDetails;

  CustomerUpdateOrderRequest({
    required this.orderId,
    required this.quantity,
    required this.orderDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'quantity': quantity,
      'orderDetails': orderDetails,
    };
  }
}
