class SellerUpdateOrderRequest {
  int? orderId;
  String? orderStatus;

  SellerUpdateOrderRequest({
    required this.orderId,
    required this.orderStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderStatus': orderStatus,
    };
  }
}
