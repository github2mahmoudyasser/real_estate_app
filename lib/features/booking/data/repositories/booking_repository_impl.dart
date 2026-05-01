import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_datasource.dart';
import '../mappers/booking_mapper.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  const BookingRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PropertyEntity>> getPropertyById(
    int propertyId,
  ) async {
    return safeCall(() async {
      final model = await _remoteDataSource.getPropertyById(propertyId);
      return BookingMapper.toPropertyEntity(model);
    });
  }

  @override
  Future<Either<Failure, OrderEntity>> createOrder(int propertyId) async {
    return safeCall(() async {
      final model = await _remoteDataSource.createOrder(propertyId);
      return BookingMapper.toOrderEntity(model);
    });
  }
}
