import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  /// Display Styles
  static TextStyle displayLarge = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -0.5.sp,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: -0.25.sp,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    height: 1.35,
  );

  /// Headline Styles
  static TextStyle headlineLarge = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  static TextStyle headlineMedium = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  /// Title Styles
  static TextStyle titleLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  static const TextStyle titleMedium16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.66,
    letterSpacing: 0.5.sp,
  );

  /// Body Styles
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 1.43,
    letterSpacing: 0.25.sp,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.66,
    letterSpacing: 0.4.sp,
  );

  /// Label Styles
  static TextStyle labelLarge = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1.sp,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.66,
    letterSpacing: 0.5.sp,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.5.sp,
  );
}
