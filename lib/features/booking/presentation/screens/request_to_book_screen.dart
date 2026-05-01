// features/booking/presentation/pages/request_to_book_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/entities/property_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'review_data_screen.dart';

class RequestToBookScreen extends StatelessWidget {
  const RequestToBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingCubit>()..loadProperty(),
      child: const _RequestToBookView(),
    );
  }
}

class _RequestToBookView extends StatelessWidget {
  const _RequestToBookView();

  static const double _serviceFee = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Request to Book',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BookingPropertyLoaded) {
            return _buildContent(context, state.property);
          }
          if (state is BookingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 14.sp, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<BookingCubit>().loadProperty(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, PropertyEntity property) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // ─── Property Image ───────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: property.firstImageUrl,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(
                height: 200.h,
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (_, _, _) => Container(
                height: 200.h,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // ─── Property Info ────────────────────────────
          Text(
            property.title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 4.h),

          Row(
            children: [
              Icon(Icons.location_on, size: 14.r, color: Colors.grey),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  property.address,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // ─── Property Details from API ───────────────────────────
          Row(
            children: [
              if (property.bedrooms != null)
                _buildDetailChip(Icons.bed, '${property.bedrooms} Bedrooms'),
              if (property.bathrooms != null)
                _buildDetailChip(Icons.bathtub, '${property.bathrooms} Bathrooms'),
              if (property.kitchens != null)
                _buildDetailChip(Icons.kitchen, '${property.kitchens} Kitchen'),
            ],
          ),

          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 16.h),

          // ─── Agent Info from API ───────────────────────────
          if (property.agent != null) ...[
            Text(
              'Listed by',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: const Color(0xFF1A73E8),
                    child: Text(
                      property.agent!.user?.name.substring(0, 1) ?? 'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.agent!.user?.name ?? 'Agent',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          property.agent!.company,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
          ],

          // ─── Booking Detail ───────────────────────────
          Text(
            'Booking Detail',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12.h),
          _buildDetailRow('Category', property.category?.name ?? 'N/A'),
          _buildDetailRow('Type', property.listingType.toUpperCase()),
          _buildDetailRow('Status', property.status.toUpperCase()),

          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 16.h),

          // ─── Price Breakdown ──────────────────────────
          Text(
            'Price details',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 12.h),

          _buildPriceRow('House Price', property.formattedPrice),
          SizedBox(height: 8.h),
          _buildPriceRow('HabiSpace service fee', '\$$_serviceFee'),

          SizedBox(height: 12.h),
          const Divider(),
          SizedBox(height: 12.h),

          _buildPriceRow(
            'Total',
            '\$${property.price + _serviceFee}',
            isTotal: true,
          ),

          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 16.h),

          // ─── Cancellation Policy ──────────────────────
          Text(
            'Cancellation Policy',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            'Cancel before 24 hours to receive a full refund. '
            'Cancellations made within 24 hours of the booking '
            'are non-refundable.',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          SizedBox(height: 32.h),

          // ─── Next Button ──────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<BookingCubit>(),
                    child: const ReviewDataPage(),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Next: Review Data',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.only(right: 12.w, bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.r, color: Colors.grey[600]),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
