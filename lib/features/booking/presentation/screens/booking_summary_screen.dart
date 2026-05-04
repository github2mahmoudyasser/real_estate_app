import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../widgets/booking_app_bar.dart';
import '../widgets/booking_property_section.dart';
import '../widgets/booking_order_section.dart';
import '../widgets/booking_price_section.dart';
import '../widgets/booking_pay_button.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BookingAppBar(title: 'Booking Summary'),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => context.read<BookingCubit>().loadProperty(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final property = state.property;
          final order = state.order;

          if (property == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return _BookingSummaryBody(
            property: property,
            order: order,
          );
        },
      ),
    );
  }
}

class _BookingSummaryBody extends StatelessWidget {
  final PropertyEntity property;
  final OrderEntity? order;

  const _BookingSummaryBody({
    required this.property,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          BookingPropertySection(property: property),
          SizedBox(height: 16.h),
          if (order != null) ...[
            BookingOrderSection(order: order!),
            SizedBox(height: 16.h),
            BookingPriceSection(
              property: property,
              order: order,
            ),
          ],
          if (order == null) ...[
            BookingPriceSection(property: property),
          ],
          SizedBox(height: 24.h),
          const BookingPayButton(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}