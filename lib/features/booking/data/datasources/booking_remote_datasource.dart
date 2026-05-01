import 'package:dio/dio.dart';

import '../models/order_model.dart';
import '../models/property_model.dart';

abstract class BookingRemoteDataSource {
  Future<PropertyModel> getPropertyById(int propertyId);
  Future<OrderModel> createOrder(int propertyId);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio _dio;

  const BookingRemoteDataSourceImpl(this._dio);

  /// Temp Token
  static const String _staticToken =
      '9|FtA2H7gYBkeDsgGqy532RWH3kIAdo3LSRdsNr6Da7cf3a511';

  @override
  Future<PropertyModel> getPropertyById(int propertyId) async {
    final response = await _dio.get(
      '/api/v1/properties/$propertyId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $_staticToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    final data = response.data['data'] as Map<String, dynamic>;
    return PropertyModel.fromJson(data);
  }

  @override
  Future<OrderModel> createOrder(int propertyId) async {
    final response = await _dio.post(
      '/api/v1/orders',
      data: {'property_id': propertyId},
      options: Options(
        headers: {
          'Authorization': 'Bearer $_staticToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    return OrderModel.fromJson(response.data as Map<String, dynamic>);
  }
}
