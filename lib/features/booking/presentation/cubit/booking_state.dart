import 'package:equatable/equatable.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/entities/property_entity.dart';

class BookingState extends Equatable {
  final PropertyEntity? property;
  final OrderEntity? order;
  final bool loading;
  final String? error;

  const BookingState({
    this.property,
    this.order,
    this.loading = false,
    this.error,
  });

  factory BookingState.initial() => const BookingState();

  BookingState loadingState() => BookingState(
    property: property,
    order: order,
    loading: true,
    error: null,
  );

  BookingState propertyLoaded(PropertyEntity property) => BookingState(
    property: property,
    order: order,
    loading: false,
    error: null,
  );

  BookingState errorState(String message) => BookingState(
    property: property,
    order: order,
    loading: false,
    error: message,
  );

  BookingState orderCreated(OrderEntity order) => BookingState(
    property: property,
    order: order,
    loading: false,
    error: null,
  );

  bool get isLoading => loading;
  bool get hasError => error != null && error!.isNotEmpty;
  String get errorMessage => error ?? '';
  bool get hasProperty => property != null;
  bool get hasOrder => order != null;

  @override
  List<Object?> get props => [property, order, loading, error];
}