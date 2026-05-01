import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../entities/property_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, PropertyEntity>> getPropertyById(int propertyId);
  Future<Either<Failure, OrderEntity>> createOrder(int propertyId);
}
