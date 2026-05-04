import 'package:equatable/equatable.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/property_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();
}

class BookingInitial extends BookingState {
  const BookingInitial();

  @override
  List<Object?> get props => [];
}

class BookingLoading extends BookingState {
  const BookingLoading();

  @override
  List<Object?> get props => [];
}

class BookingPropertyLoaded extends BookingState {
  final PropertyEntity property;
  final BookingEntity booking;

  const BookingPropertyLoaded(this.property, this.booking);

  @override
  List<Object?> get props => [property, booking];
}

class BookingStepUpdated extends BookingState {
  final BookingEntity booking;

  const BookingStepUpdated(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingOrderCreated extends BookingState {
  final OrderEntity order;
  final BookingEntity booking;

  const BookingOrderCreated(this.order, this.booking);

  @override
  List<Object?> get props => [order, booking];
}

class BookingSuccess extends BookingState {
  final OrderEntity order;
  final BookingEntity booking;

  const BookingSuccess(this.order, this.booking);

  @override
  List<Object?> get props => [order, booking];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}
