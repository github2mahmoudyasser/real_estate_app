import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool? passwordVisible;
  final VoidCallback? suffixPressed;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.passwordVisible,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد اللون الأساسي لو مش مستورد الملف
    const Color primaryColor = Color(0xFF1597A8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: isPassword ? !(passwordVisible ?? false) : false,
          cursorColor: primaryColor,
          style: GoogleFonts.poppins(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey.shade400
            ),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                passwordVisible ?? false
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: primaryColor,
                size: 20.sp,
              ),
              onPressed: suffixPressed,
            )
                : null,
            filled: true,
            fillColor: const Color(0xFFF7F8F9),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

            // الحواف في الحالة العادية
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),

            // الحواف عند الضغط
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: primaryColor, width: 1.5),
            ),

            // حواف الخطأ
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
