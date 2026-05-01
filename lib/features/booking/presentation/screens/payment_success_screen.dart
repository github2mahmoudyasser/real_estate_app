// features/booking/presentation/pages/payment_success_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/payment_method.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Booking Receipt',
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
          if (state is! BookingSuccess) {
            return const Center(child: CircularProgressIndicator());
          }

          final order = state.order;
          final booking = state.booking;
          final property = booking.property;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),

                // ─── Success Icon ─────────────────────────────
                Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: const Color(0xFF2E7D32),
                    size: 48.r,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Please fill out the form below to finish\nyour payment details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 32.h),

                // ─── Amount Card ──────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '\$${order.amount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Payment ${order.status.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // ─── Receipt Details ──────────────────────────
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
                      // Payment Details
                      _buildSectionTitle('Payment Details'),
                      SizedBox(height: 12.h),

                      _buildReceiptRow('Transaction ID', '#${order.id}'),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Payment Date',
                        _formatDate(order.createdAt),
                      ),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Payment Method',
                        _paymentMethodLabel(booking.paymentMethod),
                      ),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Sender Name',
                        booking.residentData?.fullName ?? '-',
                      ),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Total Amount',
                        '\$${order.amount.toStringAsFixed(0)}',
                        isHighlight: true,
                      ),

                      SizedBox(height: 16.h),
                      const Divider(),
                      SizedBox(height: 16.h),

                      // Booking Summary
                      _buildSectionTitle('Booking Summary'),
                      SizedBox(height: 12.h),

                      _buildReceiptRow(
                        'Property',
                        property?.title ?? 'Sunny Downtown Apartment',
                      ),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Location',
                        property?.address ??
                            'Downtown Cairo — Talaat Harb',
                      ),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Book Appointment',
                        '12 Sept 2025 — 09:00',
                      ),
                      SizedBox(height: 8.h),
                      _buildReceiptRow(
                        'Status',
                        order.status.toUpperCase(),
                        isHighlight: true,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ─── Cancellation Policy ──────────────────────
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFFFE082)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16.r,
                        color: const Color(0xFFF9A825),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Non-refundable. Cancel before 24 hours to receive a full refund.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFF9A825),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // ─── Download Receipt Button ──────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: implement PDF generation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Receipt download coming soon!',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.download, size: 20.r),
                    label: Text(
                      'Download Receipt (PDF)',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A73E8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // ─── Back to Home Button ──────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1A73E8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A73E8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
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
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isHighlight ? const Color(0xFF1A73E8) : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year} — '
          '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
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
