import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/property_entity.dart';
import '../repositories/booking_repository.dart';

class GetPropertyDetailsUseCase {
  final BookingRepository repository;

  GetPropertyDetailsUseCase(this.repository);

  Future<Either<Failure, PropertyEntity>> call(int propertyId) {
    return repository.getPropertyById(propertyId);
  }
}
