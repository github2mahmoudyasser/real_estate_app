import 'package:flutter/material.dart';

import '../../domain/entities/property_entity.dart';
import '../../domain/entities/order_entity.dart';
import 'booking_info_row.dart';

class BookingPriceSection extends StatelessWidget {
  final PropertyEntity property;
  final OrderEntity? order;

  const BookingPriceSection({
    super.key,
    required this.property,
    this.order,
  });

  double get total => order?.amount ?? property.price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingInfoRow('Property Price', property.formattedPrice),
        if (order != null) ...[
          BookingInfoRow('Service Fee', '\$250'),
          BookingInfoRow('Total', '\$${total.toStringAsFixed(0)}', isBold: true),
        ],
        if (order == null) ...[
          const Divider(),
          BookingInfoRow('Total', property.formattedPrice, isBold: true),
        ],
      ],
    );
  }
}