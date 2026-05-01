// features/booking/presentation/pages/booking_confirmation_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/property_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'booking_summary_screen.dart';

class BookingConfirmationPage extends StatelessWidget {
  const BookingConfirmationPage({super.key});

  PropertyEntity? _getProperty(BookingState state) {
    if (state is BookingPropertyLoaded) return state.property;
    if (state is BookingStepUpdated) return state.booking.property;
    if (state is BookingOrderCreated) return state.booking.property;
    if (state is BookingSuccess) return state.booking.property;
    return null;
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
        centerTitle: true,
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          final booking = _getBooking(state);
          final property = _getProperty(state);

          if (property == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                // ─── Success Message ──────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFF81C784)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF2E7D32),
                        size: 24.r,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Congratulations! We have sent your booking details to the property owner.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF2E7D32),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // ─── Booking Details Card ─────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey[200]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Info from API
                      Text(
                        property.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 13.r,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              property.address,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),
                      const Divider(),
                      SizedBox(height: 16.h),

                      // ─── User Info ────────────────────────
                      Text(
                        'Booking Information',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      _buildInfoRow(
                        'Full Name',
                        booking.residentData?.fullName ?? '-',
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        'Phone',
                        booking.residentData?.phone ?? '-',
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        'Email Address',
                        booking.residentData?.email ?? '-',
                      ),

                      SizedBox(height: 16.h),
                      const Divider(),
                      SizedBox(height: 16.h),

                      // ─── Booking Details ──────────────────
                      Text(
                        'Booking Details',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      _buildInfoRow('Residence', 'Sunny Downtown Apartment'),
                      SizedBox(height: 8.h),
                      _buildInfoRow('Location', 'Downtown Cairo — Talaat Harb'),
                      SizedBox(height: 8.h),
                      _buildInfoRow('Book Appointment', '12 Sept 2025 — 09:00'),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        'Payment Method',
                        _paymentMethodLabel(booking.paymentMethod),
                      ),

                      SizedBox(height: 16.h),
                      const Divider(),
                      SizedBox(height: 16.h),

                      // ─── Price Details ────────────────────
                      Text(
                        'Price Details',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      _buildInfoRow('House Price', '\$325,000'),
                      SizedBox(height: 8.h),
                      _buildInfoRow('HabiSpace service fee', '\$250'),
                      SizedBox(height: 8.h),
                      const Divider(),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        'Total',
                        '\$${(325000 + booking.addonsTotal + booking.insurancePrice + 250).toStringAsFixed(0)}',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ─── Finish Payment Button ────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<BookingCubit>(),
                          child: const BookingSummaryPage(),
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
                      'Finish Payment',
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

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: isTotal ? 14.sp : 13.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  String _paymentMethodLabel(PaymentMethod? method) {
    switch (method) {
      case PaymentMethod.card:
        return 'Credit / Debit Card';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.mobileBanking:
        return 'Mobile Banking';
      default:
        return '-';
    }
  }
}
