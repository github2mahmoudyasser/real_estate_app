import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int id;
  final double amount;
  final String currency;
  final String status;
  final String stripeSessionId;
  final String createdAt;
  final String paymentUrl;

  // مهم: فكينا الـ coupling
  final int? propertyId;

  const OrderEntity({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.stripeSessionId,
    required this.createdAt,
    required this.paymentUrl,
    this.propertyId,
  });

  @override
  List<Object?> get props => [
    id,
    amount,
    currency,
    status,
    stripeSessionId,
    createdAt,
    paymentUrl,
    propertyId,
  ];
}
