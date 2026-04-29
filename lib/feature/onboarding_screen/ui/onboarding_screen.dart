

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realstateapp/feature/login_screen/presentation/ui/login_view.dart';
import 'package:realstateapp/shared/customindicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../shared/custombotton.dart';
import '../widgets/circle_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 555.h, //
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r), //
                bottomRight: Radius.circular(16.r), //
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/banner.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),


          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), //
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  Text(
                    'Find Your Perfect Home, Anywhere',
                    style: GoogleFonts.poppins( //
                      fontSize: 20.sp, //
                      fontWeight: FontWeight.w600, //
                      color: AppColors.primaryBlack, //
                      height: 1.27, //
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // الوصف
                  Text(
                    'Start your journey with a comfortable and reliable home search.',
                    style:GoogleFonts.poppins( //
                      fontSize: 14.sp, //
                      fontWeight: FontWeight.w400, //
                      color: AppColors.primaryBlack.withOpacity(0.52), //
                      height: 1.32, //
                    ),
                  ),

                  SizedBox(height: 12.h),


                   // indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     CustomIndicator(),

                      //circle button
                      Row(
                        children: [
                          CustomCircleButton(
                            icon: Icons.arrow_back_ios_new,
                            bgColor: AppColors.primaryColor,
                            iconColor: Colors.white,
                            onTap: () {},
                          ),
                          SizedBox(width: 8.w),
                          CustomCircleButton(
                            icon: Icons.arrow_forward_ios,
                            bgColor: AppColors.primaryColor,
                            iconColor: Colors.white,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 35.h),

                   // continue button
                  CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginView()),
                      );
                    },
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}