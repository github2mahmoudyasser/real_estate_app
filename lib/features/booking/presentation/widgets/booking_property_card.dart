import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/property_entity.dart';

class BookingPropertyCard extends StatelessWidget {
  final PropertyEntity property;

  const BookingPropertyCard({super.key, required this.property});

  String get firstImage {
    if (property.imageUrls.isEmpty) return '';
    return property.imageUrls.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: firstImage.isEmpty
              ? _buildPlaceholder()
              : CachedNetworkImage(
                  imageUrl: firstImage,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, a) => _buildLoadingPlaceholder(),
                  errorWidget: (_, b, c) => _buildPlaceholder(),
                ),
        ),
        SizedBox(height: 12.h),
        Text(
          property.title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.location_on, size: 16.sp, color: Colors.grey[600]),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                property.address,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.star, size: 16.sp, color: Colors.amber),
            SizedBox(width: 4.w),
            Text(
              property.rating?.toStringAsFixed(1) ?? 'New',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              property.rating != null
                  ? ' (${property.salesCount ?? 0} Reviews)'
                  : ' (No reviews)',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180.h,
      color: Colors.grey[200],
      child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      height: 180.h,
      color: Colors.grey[200],
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
