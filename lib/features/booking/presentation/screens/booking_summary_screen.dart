import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realstateapp/core/constants/custom_app_bar.dart';
import 'package:realstateapp/core/di/service_locator.dart';
import 'package:realstateapp/shared/custombotton.dart';

import '../../domain/entities/property_entity.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import '../views/booking_empty_view.dart';
import '../views/booking_error_view.dart';
import '../views/booking_loading_view.dart';
import '../widgets/booking_cancellation_policy.dart';
import '../widgets/booking_details_section.dart';
import '../widgets/booking_price_section.dart';
import '../widgets/booking_property_card.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingCubit>()..loadProperty(),
      child: const _BookingSummaryView(),
    );
  }
}

class _BookingSummaryView extends StatelessWidget {
  const _BookingSummaryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Request to Book'),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const BookingLoadingView();
          }

          if (state.hasError) {
            return BookingErrorView(
              message: state.errorMessage,
              onRetry: () => context.read<BookingCubit>().loadProperty(),
            );
          }

          final property = state.property;
          if (property == null) {
            return const BookingEmptyView();
          }

          return _buildContent(property);
        },
      ),
    );
  }

  Widget _buildContent(PropertyEntity property) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingPropertyCard(property: property),
          SizedBox(height: 24.h),
          const BookingDetailsSection(),
          SizedBox(height: 24.h),
          BookingPriceSection(propertyPrice: property.price),
          SizedBox(height: 24.h),
          const BookingCancellationPolicy(),
          SizedBox(height: 32.h),
          CustomButton(
            text: 'Next: Review Data',
            onPressed: () {},
            backgroundColor: const Color(0xFF00897B),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
