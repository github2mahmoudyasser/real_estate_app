// features/booking/presentation/pages/payment_options_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/insurance_type.dart';
import '../../domain/entities/payment_method.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'booking_confirmation_screen.dart';

class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({super.key});

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
          final booking = _extractBooking(state);
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // ─── Insurance ────────────────────────────────
                Text(
                  'Insurance',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                Text(
                  'Choose Insurance',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildInsuranceCard(
                        context: context,
                        title: 'Bargain Home',
                        price: '\$15/month',
                        type: InsuranceType.bargain,
                        isSelected: booking.insurance == InsuranceType.bargain,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildInsuranceCard(
                        context: context,
                        title: 'Smart Home',
                        price: '\$12/month',
                        type: InsuranceType.smart,
                        isSelected: booking.insurance == InsuranceType.smart,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
                const Divider(),
                SizedBox(height: 16.h),

                // ─── Payment Method ───────────────────────────
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 12.h),

                _buildPaymentMethodItem(
                  context: context,
                  icon: Icons.credit_card,
                  title: 'Credit Card / Debit Card',
                  method: PaymentMethod.card,
                  isSelected: booking.paymentMethod == PaymentMethod.card,
                ),

                SizedBox(height: 10.h),

                _buildPaymentMethodItem(
                  context: context,
                  icon: Icons.account_balance,
                  title: 'Bank Transfer',
                  method: PaymentMethod.bankTransfer,
                  isSelected:
                      booking.paymentMethod == PaymentMethod.bankTransfer,
                ),

                SizedBox(height: 10.h),

                _buildPaymentMethodItem(
                  context: context,
                  icon: Icons.phone_android,
                  title: 'Mobile Banking',
                  method: PaymentMethod.mobileBanking,
                  isSelected:
                      booking.paymentMethod == PaymentMethod.mobileBanking,
                ),

                SizedBox(height: 24.h),
                const Divider(),
                SizedBox(height: 16.h),

                // ─── Price Summary ────────────────────────────
                Text(
                  'Price details',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 12.h),

                _buildPriceRow('House Price', '\$325,000'),
                SizedBox(height: 8.h),
                _buildPriceRow(
                  'Add-Ons',
                  '\$${booking.addonsTotal.toStringAsFixed(0)}',
                ),
                SizedBox(height: 8.h),
                _buildPriceRow(
                  'Insurance',
                  '\$${booking.insurancePrice.toStringAsFixed(0)}/month',
                ),
                SizedBox(height: 8.h),
                const Divider(),
                SizedBox(height: 8.h),
                _buildPriceRow(
                  'Total',
                  '\$${(325000 + booking.addonsTotal + booking.insurancePrice).toStringAsFixed(0)}',
                  isTotal: true,
                ),

                SizedBox(height: 32.h),

                // ─── Next Button ──────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: booking.paymentMethod == null
                        ? null
                        : () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<BookingCubit>(),
                                child: const BookingConfirmationPage(),
                              ),
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A73E8),
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Next: Confirmation',
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

  Widget _buildInsuranceCard({
    required BuildContext context,
    required String title,
    required String price,
    required InsuranceType type,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.read<BookingCubit>().selectInsurance(type),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A73E8) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? const Color(0xFFE8F0FE) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 20.r,
                  color: isSelected ? const Color(0xFF1A73E8) : Colors.grey,
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    size: 16.r,
                    color: const Color(0xFF1A73E8),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              price,
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF1A73E8)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required PaymentMethod method,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.read<BookingCubit>().selectPaymentMethod(method),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1A73E8) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? const Color(0xFFE8F0FE) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.r,
              color: isSelected ? const Color(0xFF1A73E8) : Colors.grey,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20.r,
              color: isSelected ? const Color(0xFF1A73E8) : Colors.grey,
            ),
          ],
        ),
      ),
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

  BookingEntity _extractBooking(BookingState state) {
    if (state is BookingPropertyLoaded) return state.booking;
    if (state is BookingStepUpdated) return state.booking;
    if (state is BookingOrderCreated) return state.booking;
    if (state is BookingSuccess) return state.booking;
    return BookingEntity(propertyId: 1);
  }
}
