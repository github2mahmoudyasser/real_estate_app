
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../../../core/shared_widgets/custombotton.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_validation.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: BlocConsumer<LoginCubit, AuthStates>(
              listener: (context, state) {
                if (state is AuthSuccessState) {

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                        (route) => false,
                  );
                  // 1. رسالة نجاح خفيفة
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Welcome Back!'),
                      backgroundColor: Colors.green,
                    ),
                  );



                } else if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.h),

                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/splash.png',
                            width: 170.w,
                            height: 51.h,
                            color: AppColors.primaryColor,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Sign In Account',
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E1E1E),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // --- حقول الإدخال ---
                    CustomTextField(
                      label: 'Email',
                      hint: 'insert your email',
                      controller: _emailController,
                      validator: AppValidators.emailOrPhone,
                    ),

                    SizedBox(height: 20.h),

                    CustomTextField(
                      label: 'Password',
                      hint: 'insert your password',
                      controller: _passwordController,
                      isPassword: true,
                      passwordVisible: isPasswordVisible,
                      suffixPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      validator: AppValidators.password,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // --- زرار Login الأساسي ---
                    state is AuthLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                      text: 'login',
                      height: 48.h,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),

                    SizedBox(height: 24.h),

                    // --- or login with ---
                    Center(
                      child: Text(
                        'or login with',
                        style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // --- أزرار السوشيال ميديا ---
                    CustomButton(
                      text: 'Continue with Google',
                      textColor: Colors.black,
                      height: 48.h,
                      iconPath: 'assets/icon/google.png',
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey.shade300,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Continue with Apple',
                      textColor: Colors.white,
                      height: 48.h,
                      iconPath: 'assets/icon/apple.png',
                      backgroundColor: Colors.black,
                      onPressed: () {},
                    ),

                    SizedBox(height: 30.h),

                    _buildFooterLink("Don't have an account? ", "Sign up"),
                    SizedBox(height: 24.h),
                    _buildFooterLink("By signing in, you agree to our ", "Terms and Conditions", fontSize: 10.sp),
                    _buildFooterLink("Learn how we use your data ", "in our Privacy Policy", fontSize: 10.sp),
                    SizedBox(height: 20.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text, String actionText, {double? fontSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: GoogleFonts.poppins(fontSize: fontSize ?? 13.sp)),
        Text(
          actionText,
          style: GoogleFonts.poppins(
            fontSize: fontSize ?? 13.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

