import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/property_entity.dart';

class BookingPropertySection extends StatelessWidget {
  final PropertyEntity property;

  const BookingPropertySection({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: property.firstImageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(
              height: 180,
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (_, _, _) => Container(
              height: 180,
              color: Colors.grey[200],
              child: const Icon(Icons.image_not_supported),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          property.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                property.address,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}