// features/booking/presentation/pages/review_data_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/addon_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/resident_data_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'payment_options_screen.dart';

class ReviewDataPage extends StatefulWidget {
  const ReviewDataPage({super.key});

  @override
  State<ReviewDataPage> createState() => _ReviewDataPageState();
}

class _ReviewDataPageState extends State<ReviewDataPage> {
  final _formKey = GlobalKey<FormState>();

  // Static user data مؤقتاً
  late final TextEditingController _nameController = TextEditingController(
    text: 'Wade Warren',
  );
  late final TextEditingController _phoneController = TextEditingController(
    text: '(603) 555-0123',
  );
  late final TextEditingController _emailController = TextEditingController(
    text: 'anna.fali@example.com',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onNext(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final nameParts = _nameController.text.trim().split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    context.read<BookingCubit>().updateResidentData(
      ResidentDataEntity(
        firstName: firstName,
        lastName: lastName,
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        nationality: 'US',
        idNumber: '123456789',
      ),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<BookingCubit>(),
          child: const PaymentOptionsPage(),
        ),
      ),
    );
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
          final booking = _extractBooking(state);
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // ─── Resident Data ────────────────────────────
                  Text(
                    'Resident Data',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Name is required' : null,
                  ),

                  SizedBox(height: 12.h),

                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Phone is required' : null,
                  ),

                  SizedBox(height: 12.h),

                  _buildTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Invalid email';
                      return null;
                    },
                  ),

                  SizedBox(height: 12.h),

                  // ─── Required Notice ──────────────────────────
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
                            'ID Card and Marriage Certificate required upon arrival',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFFF9A825),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                  const Divider(),
                  SizedBox(height: 16.h),

                  // ─── Add-ons ──────────────────────────────────
                  Text(
                    'Add-Ons',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  ...booking.addons.map(
                    (addon) => _buildAddonItem(context, addon),
                  ),

                  SizedBox(height: 16.h),
                  const Divider(),
                  SizedBox(height: 12.h),

                  // ─── Price Summary ────────────────────────────
                  _buildPriceRow('House Price', '\$325,000'),
                  SizedBox(height: 8.h),
                  _buildPriceRow(
                    'Monthly Add-On',
                    '\$${booking.addonsTotal.toStringAsFixed(0)}',
                  ),
                  SizedBox(height: 8.h),
                  const Divider(),
                  SizedBox(height: 8.h),
                  _buildPriceRow(
                    'Total',
                    '\$${(325000 + booking.addonsTotal).toStringAsFixed(0)}',
                    isTotal: true,
                  ),

                  SizedBox(height: 32.h),

                  // ─── Next Button ──────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () => _onNext(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Next: Payment Details',
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

  Widget _buildAddonItem(BuildContext context, AddonEntity addon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: addon.isSelected ? const Color(0xFF1A73E8) : Colors.grey[300]!,
        ),
        color: addon.isSelected ? const Color(0xFFE8F0FE) : Colors.white,
      ),
      child: Row(
        children: [
          Checkbox(
            value: addon.isSelected,
            activeColor: const Color(0xFF1A73E8),
            onChanged: (_) =>
                context.read<BookingCubit>().toggleAddon(addon.id),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addon.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '\$${addon.price.toStringAsFixed(0)}/month',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF1A73E8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
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

  BookingEntity _extractBooking(BookingState state) {
    if (state is BookingPropertyLoaded) return state.booking;
    if (state is BookingStepUpdated) return state.booking;
    if (state is BookingOrderCreated) return state.booking;
    if (state is BookingSuccess) return state.booking;
    return BookingEntity(
      propertyId: 1,
      addons: defaultAddons,
    );
  }
}
