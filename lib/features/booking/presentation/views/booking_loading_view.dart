import 'package:flutter/material.dart';

class BookingLoadingView extends StatelessWidget {
  const BookingLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}