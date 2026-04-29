import 'package:dio/dio.dart';
import 'package:realstateapp/core/constants/preference_manager.dart';
import 'package:realstateapp/core/constants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get token from preference manager if available
    final String? token =
        PreferenceManager().getString(StorageKeys.authToken) ??
        PreferenceManager().getString('token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Clear user data on unauthorized error
      PreferenceManager().clear();
    }

    handler.next(err);
  }
}
