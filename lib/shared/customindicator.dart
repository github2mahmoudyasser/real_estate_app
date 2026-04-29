
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';
class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) => Container(
        width: index == 0 ? 45.w : 45.w,
        height: 4.h,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: index == 0
              ? AppColors.primaryColor
              : AppColors.grey.withOpacity(0.52),
          borderRadius: BorderRadius.circular(10.r),
        ),
      )),
    );
  }
}
