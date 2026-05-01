// features/booking/presentation/pages/booking_summary_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/insurance_type.dart';
import '../../domain/entities/property_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'full_payment_form_screen.dart';

class BookingSummaryPage extends StatelessWidget {
  const BookingSummaryPage({super.key});

  PropertyEntity _getProperty(BookingState state) {
    if (state is BookingPropertyLoaded) return state.property;
    if (state is BookingStepUpdated) return state.booking.property!;
    if (state is BookingOrderCreated) return state.booking.property!;
    if (state is BookingSuccess) return state.booking.property!;
    return const PropertyEntity(id: 0, title: '', address: '', imageUrls: [], price: 0);
  }

  BookingEntity _getBooking(BookingState state) {
    if (state is BookingPropertyLoaded) return state.booking;
    if (state is BookingStepUpdated) return state.booking;
    if (state is BookingOrderCreated) return state.booking;
    if (state is BookingSuccess) return state.booking;
    return const BookingEntity(propertyId: 1);
  }

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
          'Booking Detail',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          final property = _getProperty(state);
          final booking = _getBooking(state);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // ─── Property Image from API ───────────────────────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: property.firstImageUrl,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      height: 180.h,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (_, _, _) => Container(
                      height: 180.h,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // ─── Property Info from API ────────────────────────────
                Text(
                  property.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 4.h),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 13.r, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        property.address,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),

                // ─── Booking Info from API ─────────────────────────────
                _buildSectionTitle('Booking Information'),
                SizedBox(height: 12.h),
                _buildInfoRow('Full Name', booking.residentData?.fullName ?? '-'),
                SizedBox(height: 8.h),
                _buildInfoRow('Phone', booking.residentData?.phone ?? '-'),
                SizedBox(height: 8.h),
                _buildInfoRow('Email', booking.residentData?.email ?? '-'),
                SizedBox(height: 8.h),
                _buildInfoRow('Category', property.category?.name ?? '-'),
                SizedBox(height: 8.h),
                _buildInfoRow('Type', property.listingType.toUpperCase()),

                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),

                // ─── Payment Info ─────────────────────────────
                _buildSectionTitle('Payment Details'),
                SizedBox(height: 12.h),
                _buildInfoRow('Payment Method', booking.paymentMethod?.label ?? '-'),
                SizedBox(height: 8.h),
                _buildInfoRow('Insurance', _insuranceLabel(booking.insurance)),

                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),

                // ─── Price Breakdown ──────────────────────────
                _buildSectionTitle('Price Details'),
                SizedBox(height: 12.h),
                _buildInfoRow('House Price', property.formattedPrice),
                SizedBox(height: 8.h),

                if (booking.addonsTotal > 0) ...[
                  _buildInfoRow(
                    'Add-Ons',
                    '\$${booking.addonsTotal.toStringAsFixed(0)}/month',
                  ),
                  SizedBox(height: 8.h),
                ],

                if (booking.insurance != null) ...[
                  _buildInfoRow(
                    'Insurance',
                    '\$${booking.insurancePrice.toStringAsFixed(0)}/month',
                  ),
                  SizedBox(height: 8.h),
                ],

                _buildInfoRow('HabiSpace service fee', '\$250'),
                SizedBox(height: 8.h),
                const Divider(),
                SizedBox(height: 8.h),
                _buildInfoRow(
                  'Total',
                  '\$${(property.price + booking.addonsTotal + booking.insurancePrice + 250).toStringAsFixed(0)}',
                  isTotal: true,
                ),

                SizedBox(height: 32.h),

                // ─── Finish Payment Button ────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<BookingCubit>(),
                            child: const FullPaymentFormPage(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A73E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Pay Now',
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
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? const Color(0xFF1A73E8) : Colors.black,
          ),
        ),
      ],
    );
  }

  String _insuranceLabel(InsuranceType? type) {
    if (type == null) return '-';
    return '${type.label} (\$${type.price.toStringAsFixed(0)}/month)';
  }
}