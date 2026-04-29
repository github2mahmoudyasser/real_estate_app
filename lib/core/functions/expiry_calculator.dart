// lib/features/product_details/presentation/widgets/expiry_calculator.dart

class ExpiryCalculator {
  static String calculateMonthsUntilExpiry(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now);

    final months = difference.inDays ~/ 30;

    if (months <= 0) {
      return 'Expired';
    } else if (months == 1) {
      return '1 month';
    } else {
      return '$months months';
    }
  }
}
