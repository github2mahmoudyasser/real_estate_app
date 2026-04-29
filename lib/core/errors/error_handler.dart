import 'package:dio/dio.dart';

import 'failures.dart';

Failure handleDioError(DioException e) {
  // 🌐 Network issues
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.connectionError) {
    return const NetworkFailure();
  }

  // ❌ Cancelled
  if (e.type == DioExceptionType.cancel) {
    return const UnknownFailure('Request was cancelled');
  }

  final response = e.response;

  if (response != null) {
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        return ValidationFailure(response.data?['message'] ?? 'Bad request');

      case 401:
        return const UnauthorizedFailure();

      case 403:
        return const ForbiddenFailure();

      case 404:
        return const NotFoundFailure();

      case 422:
        return ValidationFailure(
          response.data?['message'] ?? 'Validation error',
        );

      case 500:
      case 502:
      case 503:
        return const ServerFailure();

      default:
        return ServerFailure(
          response.data?['message'] ?? 'Unexpected server error',
        );
    }
  }

  return const UnknownFailure();
}
