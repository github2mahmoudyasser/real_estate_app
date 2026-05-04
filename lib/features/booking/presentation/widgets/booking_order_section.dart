import 'package:flutter/material.dart';

import '../../domain/entities/order_entity.dart';
import 'booking_info_row.dart';

class BookingOrderSection extends StatelessWidget {
  final OrderEntity order;

  const BookingOrderSection({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingInfoRow('Order ID', order.id.toString()),
        BookingInfoRow('Status', order.status),
        BookingInfoRow('Currency', order.currency),
        BookingInfoRow('Amount', '\$${order.amount.toStringAsFixed(0)}'),
      ],
    );
  }
}