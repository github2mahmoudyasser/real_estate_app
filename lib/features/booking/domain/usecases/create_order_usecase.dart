import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/booking_repository.dart';

class CreateOrderUseCase {
  final BookingRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(int propertyId) {
    return repository.createOrder(propertyId);
  }
}
