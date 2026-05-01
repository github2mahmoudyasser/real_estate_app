// features/booking/presentation/pages/stripe_webview_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'payment_success_screen.dart';

class StripeWebViewPage extends StatefulWidget {
  final String paymentUrl;

  const StripeWebViewPage({super.key, required this.paymentUrl});

  @override
  State<StripeWebViewPage> createState() => _StripeWebViewPageState();
}

class _StripeWebViewPageState extends State<StripeWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  // Stripe success/cancel URL patterns
  static const String _successPattern = 'success';
  static const String _cancelPattern = 'cancel';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onNavigationRequest: (request) {
            final url = request.url.toLowerCase();

            // Stripe success redirect
            if (url.contains(_successPattern)) {
              _onPaymentSuccess();
              return NavigationDecision.prevent;
            }

            // Stripe cancel redirect
            if (url.contains(_cancelPattern)) {
              _onPaymentCancelled();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Connection error: ${error.description}',
                  style: TextStyle(fontSize: 13.sp),
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _onPaymentSuccess() {
    if (!mounted) return;
    context.read<BookingCubit>().markPaymentSuccess();
  }

  void _onPaymentCancelled() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment cancelled', style: TextStyle(fontSize: 13.sp)),
        backgroundColor: Colors.orange,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => _onPaymentCancelled(),
        ),
        title: Text(
          'Secure Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Stripe lock icon — reassures user
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(Icons.lock_outline, color: Colors.green, size: 20.r),
          ),
        ],
      ),
      body: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<BookingCubit>(),
                  child: const PaymentSuccessPage(),
                ),
              ),
              // امسح كل الـ stack — المستخدم مش هيرجع للـ payment
              (route) => route.isFirst,
            );
          }
        },
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),

            // Loading overlay
            if (_isLoading)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Color(0xFF1A73E8)),
                      SizedBox(height: 16.h),
                      Text(
                        'Loading secure payment...',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
