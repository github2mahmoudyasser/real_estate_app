class OrderModel {
  final int id;
  final double amount;
  final String currency;
  final String status;
  final String stripeSessionId;
  final String createdAt;
  final String paymentUrl;
  final int? propertyId;

  const OrderModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.stripeSessionId,
    required this.createdAt,
    required this.paymentUrl,
    this.propertyId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final order = data['order'] as Map<String, dynamic>;

    return OrderModel(
      id: order['id'] as int,
      amount: double.parse(order['amount'].toString()),
      currency: order['currency'] as String,
      status: order['status'] as String,
      stripeSessionId: order['stripe_checkout_session_id'] as String,
      createdAt: order['created_at'] as String,
      paymentUrl: data['payment_url'] as String,
      propertyId: order['property_id'] as int?,
    );
  }
}
