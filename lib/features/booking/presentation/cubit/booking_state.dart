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

  BookingState copyWith({
    PropertyEntity? property,
    OrderEntity? order,
    bool? loading,
    String? error,
  }) {
    return BookingState(
      property: property ?? this.property,
      order: order ?? this.order,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  bool get isLoading => loading;
  bool get hasError {
    final e = error;
    return e != null && e.isNotEmpty;
  }
  String get errorMessage => error ?? '';

  @override
  List<Object?> get props => [property, order, loading, error];
}
