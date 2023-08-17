class CustomerUpdateOrderRequest {
  int? orderId;
  int? quantity;

  CustomerUpdateOrderRequest({
    required this.orderId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'quantity': quantity,
    };
  }
}
