// features/booking/presentation/pages/full_payment_form_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/booking_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'stripe_webview_screen.dart';

class FullPaymentFormPage extends StatefulWidget {
  const FullPaymentFormPage({super.key});

  @override
  State<FullPaymentFormPage> createState() => _FullPaymentFormPageState();
}

class _FullPaymentFormPageState extends State<FullPaymentFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onFinishPayment(BuildContext context, BookingEntity booking) {
    if (!_formKey.currentState!.validate()) return;
    if (!booking.agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please agree to the terms and cancellation policy',
            style: TextStyle(fontSize: 13.sp),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<BookingCubit>().updateCardData(
      cardNumber: _cardNumberController.text.trim(),
      expiryDate: _expiryController.text.trim(),
      cvv: _cvvController.text.trim(),
    );

    context.read<BookingCubit>().createOrder();
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
          if (state is BookingOrderCreated) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<BookingCubit>(),
                  child: StripeWebViewPage(paymentUrl: state.order.paymentUrl),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final booking = _extractBooking(state);
          final isLoading = state is BookingLoading;

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // ─── Card Number ──────────────────────────────
                  Text(
                    'Card Number',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      _CardNumberFormatter(),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Card number required';
                      if (v.replaceAll(' ', '').length < 16) {
                        return 'Enter valid 16-digit card number';
                      }
                      return null;
                    },
                    decoration: _inputDecoration(
                      hint: '0000 0000 0000 0000',
                      suffix: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/200px-Visa_Inc._logo.svg.png',
                        width: 40.w,
                        errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ─── Expiry + CVV ─────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expiration Date',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            TextFormField(
                              controller: _expiryController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                _ExpiryFormatter(),
                              ],
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Required';
                                }
                                if (v.length < 5) return 'Invalid date';
                                return null;
                              },
                              decoration: _inputDecoration(hint: 'MM/YY'),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CVV',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            TextFormField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Required';
                                }
                                if (v.length < 3) return 'Invalid CVV';
                                return null;
                              },
                              decoration: _inputDecoration(hint: '000'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  const Divider(),
                  SizedBox(height: 16.h),

                  // ─── Terms Checkbox ───────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Checkbox(
                          value: booking.agreedToTerms,
                          activeColor: const Color(0xFF1A73E8),
                          onChanged: (v) => context
                              .read<BookingCubit>()
                              .toggleTerms(v ?? false),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.read<BookingCubit>().toggleTerms(
                            !booking.agreedToTerms,
                          ),
                          child: Text(
                            'By clicking this, I agree to the Terms & Conditions and the Privacy Policy and Cancellation Policy',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // ─── Cancellation Notice ──────────────────────
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
                            'Non-refundable. Cancel before 24 hours to receive a full refund. You can read and review the cancellation policy from the details above.',
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

                  SizedBox(height: 32.h),

                  // ─── Finish Payment Button ────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _onFinishPayment(context, booking),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
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
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
      suffixIcon: suffix != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: suffix,
            )
          : null,
      suffixIconConstraints: BoxConstraints(maxHeight: 32.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xFF1A73E8)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
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

// ─── Card Number Formatter ────────────────────────────────────
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(text[i]);
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// ─── Expiry Formatter ─────────────────────────────────────────
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
