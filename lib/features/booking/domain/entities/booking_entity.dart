import 'package:equatable/equatable.dart';

import 'property_entity.dart';
import 'addon_entity.dart';
import 'resident_data_entity.dart';
import 'insurance_type.dart';
import 'payment_method.dart';

class BookingEntity extends Equatable {
  final int propertyId;
  final PropertyEntity? property;
  final ResidentDataEntity? residentData;
  final List<AddonEntity> addons;
  final InsuranceType? insurance;
  final PaymentMethod? paymentMethod;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvv;
  final bool agreedToTerms;

  const BookingEntity({
    required this.propertyId,
    this.property,
    this.residentData,
    this.addons = const [],
    this.insurance,
    this.paymentMethod,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.agreedToTerms = false,
  });

  BookingEntity copyWith({
    int? propertyId,
    PropertyEntity? property,
    ResidentDataEntity? residentData,
    List<AddonEntity>? addons,
    InsuranceType? insurance,
    PaymentMethod? paymentMethod,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    bool? agreedToTerms,
  }) {
    return BookingEntity(
      propertyId: propertyId ?? this.propertyId,
      property: property ?? this.property,
      residentData: residentData ?? this.residentData,
      addons: addons ?? this.addons,
      insurance: insurance ?? this.insurance,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
    );
  }

  double get addonsTotal =>
      addons.where((a) => a.isSelected).fold(0, (sum, a) => sum + a.price);

  double get insurancePrice => insurance?.price ?? 0;

  @override
  List<Object?> get props => [
        propertyId,
        property,
        residentData,
        addons,
        insurance,
        paymentMethod,
        cardNumber,
        expiryDate,
        cvv,
        agreedToTerms,
      ];
}