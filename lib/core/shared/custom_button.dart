import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          disabledBackgroundColor: AppColor.primaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: AppTextStyle.headlineSmall.copyWith(
                  color: AppColor.white,
                ),
              ),
      ),
    );
  }
}
