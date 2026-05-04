import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/booking_cubit.dart';

class BookingPayButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BookingPayButton({
    super.key,
    this.text = 'Pay Now',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed ?? () => context.read<BookingCubit>().createOrder(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A73E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}